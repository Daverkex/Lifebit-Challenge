output "service_name" {
  value       = module.ecs_service.name
  description = "The service name"
}

output "task_definition_role_arn" {
  value       = module.ecs_service.tasks_iam_role_arn
  description = "The task definition role ARN"
}

output "task_execution_role_arn" {
  value       = module.ecs_service.task_exec_iam_role_arn
  description = "The task execution role ARN"
}
