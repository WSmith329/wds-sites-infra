variable "site_name" {
  type        = string
  description = "Logical name for the site (used for tagging/naming)"
}

variable "environment" {
  type        = string
  description = "dev or prod"
}

variable "root_domain" {
  type        = string
  description = "Primary domain (e.g. client.com or www.client.com)"
}
