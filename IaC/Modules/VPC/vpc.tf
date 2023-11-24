data "aws_availability_zones" "available" {}

locals {
  azs = data.aws_availability_zones.available.names
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.2"

  name = var.name

  azs = local.azs

  enable_nat_gateway = true
  single_nat_gateway = true

  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 4)]

  enable_ipv6                                   = true
  public_subnet_assign_ipv6_address_on_creation = true

  public_subnet_ipv6_prefixes  = [0, 1, 2]
  private_subnet_ipv6_prefixes = [3, 4, 5]

  tags = merge(var.default_tags,
    {
      description = "ECS Challenge"
  })
}
