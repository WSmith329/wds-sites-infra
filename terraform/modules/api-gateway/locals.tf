locals {
  api_domain_name = var.environment == "prod" ? "api.${var.site_domain_name}" : "api.${var.environment}.${var.site_domain_name}"

  cors_allowed_origins = var.environment == "prod" ? [
    "https://${var.site_domain_name}",
    "https://www.${var.site_domain_name}"
    ] : [
    "https://${var.environment}.${var.site_domain_name}"
  ]

  common_tags = {
    Site        = var.api_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
