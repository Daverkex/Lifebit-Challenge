locals {
  safe_repo_name = lower(replace(var.repo_name, "/", "-"))
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_ecs_cluster" "current" {
  cluster_name = var.ecs_name
}
data "aws_iam_policy_document" "cicd" {
  statement {
    sid = "ECRWrite"
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
    sid = "GetAuthToken"
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }

  statement {
    sid = "ECSTaskWrite"
    actions = [
      "ecs:DescribeTaskDefinition",
      "ecs:RegisterTaskDefinition",
    ]
    resources = ["*"]
  }
  statement {
    sid     = "PassRolesInTaskDefinition"
    actions = ["iam:PassRole"]
    resources = [
      var.task_definition_role_arn,
      var.task_execution_role_arn
    ]
  }
  statement {
    sid = "DeployService"
    actions = [
      "ecs:DescribeServices",
      "ecs:UpdateService",
    ]
    resources = ["arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:service/${var.ecs_name}/${var.service_name}"]
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
