variable "name" {
  type        = string
  description = "VPC name"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "IPv4 CIDR block for this VPC"
}

variable "default_tags" {
  type        = map(string)
  default     = {}
  description = "Default tags filled usually by Terragrunt"
}