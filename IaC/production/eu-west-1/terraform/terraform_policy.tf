# Documentation: https://developer.hashicorp.com/terraform/language/settings/backends/s3

data "aws_iam_policy_document" "tfstate_access" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",

      // Terragrunt need check Versioning
      "s3:GetBucketVersioning",
    ]
    resources = ["${aws_s3_bucket.root.arn}/*"]
  }

  statement {
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [aws_dynamodb_table.lock.arn]
  }
}

resource "aws_iam_policy" "tfstate_access" {
  name   = "TerraformTfstatesGeneralAccess"
  policy = data.aws_iam_policy_document.tfstate_access.json
}
