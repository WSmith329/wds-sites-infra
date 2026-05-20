variable "site_name" {
  type        = string
  description = "Logical name for the site (used for tagging/naming)"
}

variable "environment" {
  type        = string
  description = "dev or prod"
}

variable "domain_name" {
  type        = string
  description = "Primary domain (e.g. client.com or www.client.com)"
}

variable "aliases" {
  type        = list(string)
  default     = []
  description = "Additional CloudFront aliases (e.g. www + root domain)"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ACM certificate ARN (must be in us-east-1 for CloudFront)"
}

variable "price_class" {
  type        = string
  default     = "PriceClass_100"
}

variable "tags" {
  type        = map(string)
  default     = {}
}