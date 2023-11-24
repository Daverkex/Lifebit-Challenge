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
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 9.2 |
| <a name="module_autoscaling"></a> [autoscaling](#module\_autoscaling) | terraform-aws-modules/autoscaling/aws | ~> 7.3 |
| <a name="module_autoscaling_sg"></a> [autoscaling\_sg](#module\_autoscaling\_sg) | terraform-aws-modules/security-group/aws | ~> 5.1 |
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | terraform-aws-modules/ecs/aws//modules/cluster | ~> 5.7 |

## Resources

| Name | Type |
|------|------|
| [aws_ami.ecs_optimized_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnet.subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_subnets"></a> [alb\_subnets](#input\_alb\_subnets) | Subnets where deploy the ALB | `list(string)` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags filled usually by Terragrunt | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Cluster name | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets where deploy the nodes | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_capacity_provider_name"></a> [capacity\_provider\_name](#output\_capacity\_provider\_name) | The capacity provider name |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The cluster ARN |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The cluster name |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | The load balancer target group ARN binded to this cluster |
<!-- END_TF_DOCS -->