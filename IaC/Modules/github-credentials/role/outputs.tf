output "role_arn" {
  value       = module.iam_github_oidc_role.arn
  description = "The role ARN"
}