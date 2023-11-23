module "iam_github_oidc_provider" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
  version = "~> 5.32"

  tags = merge(var.default_tags,
    {
      description = "Github actions provider"
  })
}
