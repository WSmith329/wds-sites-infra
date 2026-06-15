module "enquiry_form" {
  source = "../../modules/enquiry-form"

  site_dir = local.site_dir

  api_id        = module.api.api_id
  execution_arn = module.api.execution_arn

  owner_email = "william.smith29@outlook.com"
  from_email  = "no-reply@chloeleannefitness.com"
}
