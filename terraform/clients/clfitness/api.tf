module "api" {
  source = "../../modules/api-gateway"

  api_name = "${local.site_name}-api"

  environment = var.environment

  site_domain_name = var.root_domain

  cors_allowed_methods = ["POST", "OPTIONS"]
}
