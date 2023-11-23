output "bucket_arn" {
  value = aws_s3_bucket.root.arn
}

output "dynamodb_arn" {
  value = aws_dynamodb_table.lock.arn
}

output "tfstate_policy_arn" {
  value = aws_iam_policy.tfstate_access.arn
}
