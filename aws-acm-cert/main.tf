// Create ACM Certificates assuming hosted zone is created
resource "aws_acm_certificate" "cert" {
  domain_name       = www.example.com
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

// ACM Certificate validation
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

// Cert validation record
resource "aws_route53_record" "cert_validation" {
  name     = element(aws_acm_certificate.cert.domain_validation_options[*].resource_record_name,0)
  type     = element(aws_acm_certificate.cert.domain_validation_options[*].resource_record_type,0)
  zone_id  = var.zoneid
  records  = [element(aws_acm_certificate.cert.domain_validation_options[*].resource_record_value,0)]
  ttl      = 60
}
