<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | terraform-aws-modules/ecr/aws | ~> 1.2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags filled usually by Terragrunt | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | ECR name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_arn"></a> [ecr\_arn](#output\_ecr\_arn) | The ECR ARN |
| <a name="output_ecr_url"></a> [ecr\_url](#output\_ecr\_url) | The ECR URL |
<!-- END_TF_DOCS -->