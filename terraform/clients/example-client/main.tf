module "example_client_site" {
  source = "../../modules/site"

  site_name   = local.site_name
  environment = var.environment

  domain_name  = var.domain_name
  aliases = var.aliases

  acm_certificate_arn = var.acm_certificate_arn
}