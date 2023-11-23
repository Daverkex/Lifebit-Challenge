resource "aws_dynamodb_table" "lock" {
  name     = "terraform-tfstates-lock"
  hash_key = "LockID"

  billing_mode   = "PROVISIONED"
  write_capacity = 1
  read_capacity  = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.default_tags
}
