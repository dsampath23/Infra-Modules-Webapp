######################################################################
## Outputs
###
output "web_elb_name" {
  value = "${aws_alb.alb.name}"
}

output "elb_id" {
  value = "${aws_alb.alb.id}"
}

output "alb_dns_name" {
  value = "${aws_alb.alb.dns_name}"
}
