resource "aws_acm_certificate" "site" {
  provider                  = aws.us_east_1
  domain_name               = var.root_domain
  subject_alternative_names = ["*.${var.root_domain}"]

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = local.common_tags
}

resource "aws_acm_certificate_validation" "site" {
  provider        = aws.us_east_1
  certificate_arn = aws_acm_certificate.site.arn

  validation_record_fqdns = values(aws_route53_record.acm_validation)[*].fqdn
}

resource "aws_acm_certificate" "regional_wildcard" {
  domain_name               = var.root_domain
  subject_alternative_names = ["*.${var.root_domain}"]

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = local.common_tags
}
