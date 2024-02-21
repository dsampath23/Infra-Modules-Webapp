######################################################################
# Set up ELB for  server
##
resource "aws_elb" "elb" {
  name = "${var.web_elb_name}"

  subnets         = ["${var.publicisub2_id}", "${var.publicsub1_id}"]
  security_groups = ["${var.websg_id}"]
  schema        = "${var.external}"
  idle_timeout    = "${var.idle_timeout}"

  listener {
    instance_port     = "${var.web_elb_instance_port}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
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
    "Name"             = "${var.web_elb_name}"
    "Environment"      = "${var.environment_tag}"
  }
}

