resource "aws_acm_certificate" "api" {
  domain_name               = "api.${var.site_domain_name}"
  subject_alternative_names = ["api.dev.${var.site_domain_name}"]

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = local.common_tags
}

resource "aws_acm_certificate_validation" "api" {
  certificate_arn = aws_acm_certificate.api.arn

  validation_record_fqdns = values(aws_route53_record.acm_validation_api)[*].fqdn
}
