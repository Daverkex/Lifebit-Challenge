data "aws_availability_zones" "available" {}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.2"

  name = var.name

  azs         = data.aws_availability_zones.available.names
  enable_ipv6 = true

  public_subnet_ipv6_native    = true
  public_subnet_ipv6_prefixes  = [0, 1, 2]
  private_subnet_ipv6_native   = true
  private_subnet_ipv6_prefixes = [3, 4, 5]

  # RDS currently only supports dual-stack so IPv4 CIDRs will need to be provided for subnets
  # database_subnet_ipv6_native   = true
  # database_subnet_ipv6_prefixes = [6, 7, 8]

  enable_nat_gateway     = false
  create_egress_only_igw = true

  tags = merge(var.default_tags,
    {
      description = "ECS Challenge"
  })
}
