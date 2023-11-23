locals {
  safe_repo_name = lower(replace(var.repo_name, "/", "-"))
}

data "aws_iam_policy_document" "cicd" {
  statement {
    actions = [
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]
    resources = [var.ecr_arn]
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cicd" {
  name        = "cicd-${local.safe_repo_name}"
  description = "CICD permisions to deploy for repository ${var.repo_name}"
  policy      = data.aws_iam_policy_document.cicd.json
}

module "iam_github_oidc_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version = "~> 5.32"

  name = "cicd-${local.safe_repo_name}"

  subjects = ["${var.repo_name}:*"]

  policies = {
    cicd = aws_iam_policy.cicd.arn
  }

  tags = merge(var.default_tags,
    {
      description = "CICD permisions to deploy for repository ${var.repo_name}"
  })
}
