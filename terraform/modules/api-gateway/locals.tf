locals {
  cors_allowed_origins = var.environment == "prod" ? [
    "https://${var.site_domain_name}",
    "https://www.${var.site_domain_name}"
    ] : [
    "https://${var.environment}.${var.site_domain_name}"
  ]
}
