locals {  
  name_prefix = "${var.environment}-${var.site_name}"
  bucket_name = "${local.name_prefix}-site"

  common_tags = merge(var.tags, {
    Site        = var.site_name
    Environment = var.environment
    ManagedBy   = "terraform"
  })
}