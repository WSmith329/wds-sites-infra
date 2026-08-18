variable "site_dir" {
  type = string
}

variable "site_name" {
  type        = string
  description = "Logical name for the site (used for tagging/naming)"
}

variable "environment" {
  type = string
}

variable "api_id" {
  type = string
}

variable "execution_arn" {
  type = string
}

variable "owner_email" {
  type = string
}

variable "from_email" {
  type = string
}
