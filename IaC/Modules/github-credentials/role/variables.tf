variable "ecr_arn" {
  type        = string
  description = "ECR ARN to allow write permissions"
}

variable "repo_name" {
  type        = string
  description = "Github repository name"
}

variable "default_tags" {
  type        = map(string)
  default     = {}
  description = "Default tags filled usually by Terragrunt"
}
