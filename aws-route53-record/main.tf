##########################################################################
# Setting up new CNAME Record in a Hosted Zone
##

resource "aws_route53_record" "r53_record" {
  zone_id = "${var.zoneid}"
  name = "${var.name}"
  type = "${var.record_type}"
  ttl = "${var.record_ttl}"
  records = ["${var.elb_dns}"]
}
