module "example_client_site" {
  source = "../../modules/site"

  site_name   = local.site_name
  environment = var.environment

  root_domain = var.root_domain
}
