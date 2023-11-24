<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs_service"></a> [ecs\_service](#module\_ecs\_service) | terraform-aws-modules/ecs/aws//modules/service | ~> 5.7 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_subnets"></a> [alb\_subnets](#input\_alb\_subnets) | Subnets where deploy the service | `list(string)` | n/a | yes |
| <a name="input_capacity_provider_name"></a> [capacity\_provider\_name](#input\_capacity\_provider\_name) | Capacity provider name for this service | `string` | n/a | yes |
| <a name="input_cluster_arn"></a> [cluster\_arn](#input\_cluster\_arn) | Cluster where create the service | `string` | n/a | yes |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | The container image to deploy | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The container name for this task | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Container port to bind | `number` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | CPU units for this service and task | `number` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags filled usually by Terragrunt | `map(string)` | `{}` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory in MB for this service and task | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Service Name | `string` | n/a | yes |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | The ALB taget group where bind this service | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | The service name |
| <a name="output_task_definition_role_arn"></a> [task\_definition\_role\_arn](#output\_task\_definition\_role\_arn) | The task definition role ARN |
| <a name="output_task_execution_role_arn"></a> [task\_execution\_role\_arn](#output\_task\_execution\_role\_arn) | The task execution role ARN |
<!-- END_TF_DOCS -->