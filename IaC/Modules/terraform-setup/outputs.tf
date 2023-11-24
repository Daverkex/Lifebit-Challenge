output "bucket_arn" {
  value       = aws_s3_bucket.root.arn
  description = "The bucket ARN"
}

output "dynamodb_arn" {
  value       = aws_dynamodb_table.lock.arn
  description = "The dynamoDB ARN"
}

output "tfstate_policy_arn" {
  value       = aws_iam_policy.tfstate_access.arn
  description = "The generic role for access to tfstate files"
}
