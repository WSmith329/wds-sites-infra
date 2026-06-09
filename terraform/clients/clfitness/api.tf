module "api" {
  source = "./modules/api-gateway"

  name = "${local.site_name}-api"

  environment = var.environment

  site_domain_name = var.root_domain

  cors_allowed_methods = ["POST", "OPTIONS"]

  acm_certificate_arn = var.acm_cert_arn
}
