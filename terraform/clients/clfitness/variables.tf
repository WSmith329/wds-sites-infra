variable "environment" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "aliases" {
  type    = list(string)
  default = []
}