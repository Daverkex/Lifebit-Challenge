variable "name" {
  type        = string
  description = "Service Name"
}

variable "cluster_arn" {
  type        = string
  description = "Cluster where create the service"
}

variable "capacity_provider_name" {
  type        = string
  description = "Capacity provider name for this service"
}

variable "cpu" {
  type        = number
  description = "CPU units for this service and task"
}

variable "memory" {
  type        = number
  description = "Memory in MB for this service and task"
}

variable "container_name" {
  type        = string
  description = "The container name for this task"
}

variable "container_image" {
  type        = string
  description = "The container image to deploy"
}

variable "container_port" {
  type        = number
  description = "Container port to bind"
}

variable "alb_subnets" {
  type        = list(string)
  description = "Subnets where deploy the service"
}

variable "target_group_arn" {
  type        = string
  description = "The ALB taget group where bind this service"
}

variable "default_tags" {
  type        = map(string)
  default     = {}
  description = "Default tags filled usually by Terragrunt"
}