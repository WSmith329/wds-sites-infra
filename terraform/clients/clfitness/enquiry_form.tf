module "enquiry_form" {
  source = "../../modules/enquiry-form"

  environment = var.environment

  site_dir = local.site_dir

  api_id        = module.api.api_id
  execution_arn = module.api.execution_arn

  owner_email = var.owner_email
  from_email  = "no-reply@chloeleannefitness.com"
}
