variable "name" {
  type        = string
  description = "Cluster name"
}

variable "subnets" {
  type = list(string)
  description = "Subnets where deploy the nodes"
}

variable "alb_subnets" {
  type = list(string)
  description = "Subnets where deploy the ALB"
}

variable "default_tags" {
  type        = map(string)
  default     = {}
  description = "Default tags filled usually by Terragrunt"
}
