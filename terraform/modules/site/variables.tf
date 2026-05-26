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

variable "price_class" {
  type    = string
  default = "PriceClass_100"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}
