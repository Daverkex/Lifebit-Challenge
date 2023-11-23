variable "ecr_arn" {
  type        = string
  description = "ECR ARN to allow write permissions"
}

variable "ecs_name" {
  type        = string
  description = "ECS name to allow tasks updates"
}

variable "task_definition_role_arn" {
  type = string
  description = "Task definition role ARN for task to deploy"
}

variable "task_execution_role_arn" {
  type = string
  description = "Task execution role ARN for task to deploy"
}

variable "service_name" {
  type = string
  description = "Service ARN for service to update"
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
