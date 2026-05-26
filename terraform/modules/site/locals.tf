locals {
  name_prefix = "${var.environment}-${var.site_name}"
  bucket_name = "${local.name_prefix}-site"

  domain_name = var.environment == "prod" ? var.root_domain : "${var.environment}.${var.root_domain}"

  aliases = var.environment == "prod" ? [local.domain_name, "www.${local.domain_name}"] : [local.domain_name]

  common_tags = merge(var.tags, {
    Site        = var.site_name
    Environment = var.environment
    ManagedBy   = "terraform"
  })
}
