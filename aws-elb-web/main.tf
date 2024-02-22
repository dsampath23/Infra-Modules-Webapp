######################################################################
# Set up ALB for  server
##
resource "aws_alb" "alb" {
  name = "${var.web_elb_name}"

  subnets         = ["${var.publicisub2_id}", "${var.publicsub1_id}"]
  security_groups = ["${var.websg_id}"]
  internal        = "${var.external}"
  idle_timeout    = "${var.idle_timeout}"

  listener {
    instance_port     = "${var.web_elb_instance_port}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  default_action {
    target_group_arn = aws_lb_target_group.web_target.arn
    type             = "forward"
  }

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target              = "${var.healthcheck_target}"
    interval            = 30
  }

  cross_zone_load_balancing = true

  tags {
    "Name"             = "${var.web_alb_name}"
    "Environment"      = "${var.environment_tag}"
  }
}

