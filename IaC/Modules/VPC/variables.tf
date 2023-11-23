variable "default_tags" {
  type        = map(string)
  default     = {}
  description = "Default tags filled usually by Terragrunt"
}

variable "name" {
  type        = string
  description = "VPC name"
}