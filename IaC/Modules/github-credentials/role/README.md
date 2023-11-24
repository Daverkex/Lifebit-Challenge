<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_github_oidc_role"></a> [iam\_github\_oidc\_role](#module\_iam\_github\_oidc\_role) | terraform-aws-modules/iam/aws//modules/iam-github-oidc-role | ~> 5.32 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cicd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ecs_cluster.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_cluster) | data source |
| [aws_iam_policy_document.cicd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags filled usually by Terragrunt | `map(string)` | `{}` | no |
| <a name="input_ecr_arn"></a> [ecr\_arn](#input\_ecr\_arn) | ECR ARN to allow write permissions | `string` | n/a | yes |
| <a name="input_ecs_name"></a> [ecs\_name](#input\_ecs\_name) | ECS name to allow tasks updates | `string` | n/a | yes |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | Github repository name | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Service ARN for service to update | `string` | n/a | yes |
| <a name="input_task_definition_role_arn"></a> [task\_definition\_role\_arn](#input\_task\_definition\_role\_arn) | Task definition role ARN for task to deploy | `string` | n/a | yes |
| <a name="input_task_execution_role_arn"></a> [task\_execution\_role\_arn](#input\_task\_execution\_role\_arn) | Task execution role ARN for task to deploy | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The role ARN |
<!-- END_TF_DOCS -->