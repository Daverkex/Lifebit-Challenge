resource "random_pet" "s3_name" {}

resource "random_string" "s3_random_suffix" {
  length = 4

  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "aws_s3_bucket" "root" {
  bucket        = "${random_pet.s3_name.id}-${random_string.s3_random_suffix.result}"
  force_destroy = true

  tags = merge(var.default_tags,
    {
      name        = "Terraform tfstates",
      description = "Bucket for storing all Terraform tfstates"
  })

  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_s3_bucket_versioning" "root" {
  bucket = aws_s3_bucket.root.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "root" {
  bucket = aws_s3_bucket.root.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "root" {
  bucket = aws_s3_bucket.root.id
  rule {
    id     = "default"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 3
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }
    noncurrent_version_expiration {
      noncurrent_days = 180
    }
  }
}

// Terragrunt recommended bucket policy
resource "aws_s3_bucket_policy" "root" {
  bucket = aws_s3_bucket.root.id
  policy = data.aws_iam_policy_document.root.json
}
data "aws_caller_identity" "current" {}
data "aws_iam_policy_document" "root" {
  statement {
    sid = "RootAccess"
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type        = "AWS"
    }
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.root.arn,
      "${aws_s3_bucket.root.arn}/*"
    ]
  }
  statement {
    sid    = "EnforcedTLS"
    effect = "Deny"
    principals {
      identifiers = ["*"]
      type        = "*"
    }
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.root.arn,
      "${aws_s3_bucket.root.arn}/*"
    ]
    condition {
      test     = "Bool"
      values   = ["false"]
      variable = "aws:SecureTransport"
    }
  }
}
