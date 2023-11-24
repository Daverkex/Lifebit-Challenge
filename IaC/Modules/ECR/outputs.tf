output "ecr_arn" {
  value       = module.ecr.repository_arn
  description = "The ECR ARN"
}

output "ecr_url" {
  value       = module.ecr.repository_url
  description = "The ECR URL"
}
