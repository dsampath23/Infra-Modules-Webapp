######################################################################
# Set up launch config for Web server, target group and attachement
##
resource "template_file" "webui_user_data" {
    template  = "bootstrap/userdata.tpl"
}

resource "aws_launch_configuration" "launchconf1" {
    name = "${var.webui_launch_confname}"
    image_id = "${var.webuiapi_ami}"
    instance_type = "${var.webuiapi_instancestype}"
	key_name = "${var.aws_key_name}"
	security_groups = ["${var.webuisg_id}"]
	iam_instance_profile = "${var.webuiapi_instancerole}"
	user_data="${template_file.webui_user_data.rendered}"
}


resource "aws_lb_target_group" "webtarget" {
  name     = "webtargetgroup"
  port     = 80
  protocol = "HTTP"
}


resource "aws_autoscaling_attachment" "webtarget_attach" {
  autoscaling_group_name = aws_autoscaling_group.1.name
  alb_target_group_arn  = aws_lb_target_group.webtarget.arn
}

######################################################################
# Set up launch config for App server, target group and attachement
##
resource "template_file" "webapi_user_data" {
    template  = "bootstrap/userdata.tpl
}

resource "aws_launch_configuration" "launchconf2" {
    name = "${var.webapi_launch_confname}"
    image_id = "${var.webuiapi_ami}"
    instance_type = "${var.webuiapi_instancestype}"
	key_name = "${var.aws_key_name}"
	security_groups = ["${var.webapisg_id}"]
	iam_instance_profile = "${var.webuiapi_instancerole}"
	user_data="${template_file.webapi_user_data.rendered}"
}

resource "aws_lb_target_group" "apitarget" {
  name     = "apitargetgroup"
  port     = 80
  protocol = "HTTP"
}


resource "aws_autoscaling_attachment" "apitarget_attach" {
  autoscaling_group_name = aws_autoscaling_group.2.name
  alb_target_group_arn  = aws_lb_target_group.apitarget.arn
}

######################################################################
# Set up ELB for Web server
##
resource "aws_elb" "elb1" {
  name = "${var.webui_elb_name}"
  subnets = [ "${var.privatesub2_id}" , "${var.privatesub1_id}" ]
  security_groups = ["${var.webuisg_id}"]
  internal = "true"

  listener {
    instance_port = "${var.webui_elb_instance_port}"
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 10
    unhealthy_threshold = 2
    timeout = 5
    target = "HTTP:80/"
    interval = 30
  }

  cross_zone_load_balancing = true

  tags {
		"Name" 				= "${var.webui_elb_name}"
		"Environment" 		= "${var.environment_tag}"		
}

######################################################################
# Set up ELB for App server
##
resource "aws_elb" "elb2" {
  name = "${var.webapi_elb_name}"
  subnets = [ "${var.privatesub4_id}" , "${var.privatesub3_id}" ]
  security_groups = ["${var.webapisg_id}"]
  internal = "true"

  listener {
    instance_port = "${var.webapi_elb_instance_port}"
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 10
    unhealthy_threshold = 2
    timeout = 5
    target = "HTTP:80/"
    interval = 30
  }

  cross_zone_load_balancing = true

  tags {
		"Name" 				= "${var.webapi_elb_name}"
		"Environment" 		= "${var.environment_tag}"		
}

######################################################################
# Set up auto scaling group for Web server
##
resource "aws_autoscaling_group" "1" {
	name = "${var.webui_auto_name}"
	max_size = 2
	min_size = 1
	health_check_grace_period = 300
	health_check_type = "EC2"
	desired_capacity = 1
	force_delete = true
	load_balancers = ["${aws_elb.elb1.name}"]
	vpc_zone_identifier = [ "${var.privatesub2_id}" , "${var.privatesub1_id}" ]
	launch_configuration = "${aws_launch_configuration.launchconf1.name}"

    tag {
		key = "Name"
		value = "${var.webui_auto_scale_instname}"
		propagate_at_launch = true
	}
}

######################################################################
# Set up auto scaling group for App server
##
resource "aws_autoscaling_group" "2" {
	name = "${var.webapi_auto_name}"
	max_size = 2
	min_size = 1
	health_check_grace_period = 300
	health_check_type = "EC2"
	desired_capacity = 1
	force_delete = true
	load_balancers = ["${aws_elb.elb2.name}"]
	vpc_zone_identifier = [ "${var.privatesub4_id}" , "${var.privatesub3_id}" ]
	launch_configuration = "${aws_launch_configuration.launchconf2.name}"

	tag {
		key = "Name"
		value = "${var.webapi_auto_scale_instname}"
		propagate_at_launch = true
	}
}

######################################################################
# Set up auto scale up policy for Web server
##
resource "aws_autoscaling_policy" "scale-up1" {
    name = "${var.webui_scale_up}"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.1.name}"
}

######################################################################
# Set up auto scale down policy for Web server
##
resource "aws_autoscaling_policy" "scale-down1" {
    name = "${var.webui_scale_down}"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.1.name}"
}

######################################################################
# Set up auto scale up policy for App server
##
resource "aws_autoscaling_policy" "scale-up2" {
    name = "${var.webapi_scale_up}"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.2.name}"
}

######################################################################
# Set up auto scale down policy for App server
##
resource "aws_autoscaling_policy" "scale-down2" {
    name = "${var.webapi_scale_down}"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.2.name}"
}

######################################################################
# Set up auto scale trigger (to add new instance) for Web server
##
resource "aws_cloudwatch_metric_alarm" "cpu-high1" {
    alarm_name = "cpu-util-high-instance"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "System/Windows"
    period = "300"
    statistic = "Maximum"
    threshold = "60"
    alarm_description = "This metric monitors ec2 cpu for high utilization on instances"
    alarm_actions = [
        "${aws_autoscaling_policy.scale-up1.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.1.name}"
    }
}

######################################################################
# Set up auto scale trigger (to remove an instance) for Web server
##
resource "aws_cloudwatch_metric_alarm" "cpu-low1" {
    alarm_name = "cpu-util-low-instance"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "System/Windows"
    period = "300"
    statistic = "Maximum"
    threshold = "40"
    alarm_description = "This metric monitors ec2 cpu for low utilization on instance"
    alarm_actions = [
        "${aws_autoscaling_policy.scale-down1.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.1.name}"
    }
}

######################################################################
# Set up auto scale trigger (to add new instance) for App server
##
resource "aws_cloudwatch_metric_alarm" "cpu-high2" {
    alarm_name = "cpu-util-high-instance"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "System/Windows"
    period = "300"
    statistic = "Maximum"
    threshold = "60"
    alarm_description = "This metric monitors ec2 cpu for high utilization on instances"
    alarm_actions = [
        "${aws_autoscaling_policy.scale-up2.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.2.name}"
    }
}

######################################################################
# Set up auto scale trigger (to remove an instance) for App server
##
resource "aws_cloudwatch_metric_alarm" "cpu-low2" {
    alarm_name = "cpu-util-low-instance"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "System/Windows"
    period = "300"
    statistic = "Maximum"
    threshold = "40"
    alarm_description = "This metric monitors ec2 cpu for low utilization on instance"
    alarm_actions = [
        "${aws_autoscaling_policy.scale-down2.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.2.name}"
    }
}
