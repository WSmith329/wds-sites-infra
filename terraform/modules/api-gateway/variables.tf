variable "api_name" {
  type        = string
  description = "Name of the API Gateway"
}

variable "environment" {
  type        = string
  description = "dev or prod"
}

variable "site_domain_name" {
  type        = string
  description = "Name of the API Gateway"
}

variable "cors_allowed_methods" {
  type    = list(string)
  default = ["POST", "GET", "OPTIONS"]
}

variable "cors_allowed_headers" {
  type    = list(string)
  default = ["content-type", "authorization"]
}

variable "cors_max_age" {
  type    = number
  default = 300
}

variable "throttle_burst_limit" {
  type    = number
  default = 100
}

variable "throttle_rate_limit" {
  type    = number
  default = 50
}

# WAF
variable "waf_acl_arn" {
  type    = string
  default = null
}
