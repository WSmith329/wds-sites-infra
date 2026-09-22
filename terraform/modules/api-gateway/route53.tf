data "aws_route53_zone" "site" {
  name         = var.site_domain_name
  private_zone = false
}

resource "aws_route53_record" "acm_validation_api" {
  for_each = {
    for dvo in aws_acm_certificate.api.domain_validation_options :
    dvo.domain_name => dvo
  }

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.site.zone_id

  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]

  ttl = 60
}

resource "aws_route53_record" "api" {
  zone_id = data.aws_route53_zone.site.zone_id
  name    = local.api_domain_name
  type    = "A"

  alias {
    name                   = aws_apigatewayv2_domain_name.this.domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.this.domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}
