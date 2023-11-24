# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#ecs-optimized-ami-linux
data "aws_ami" "ecs_optimized_ami" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 7.3"

  name = var.name

  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"

  enable_monitoring = false

  vpc_zone_identifier = var.subnets

  image_id      = data.aws_ami.ecs_optimized_ami.image_id
  instance_type = "t3.micro"

  security_groups = [module.autoscaling_sg.security_group_id]
  user_data = base64encode(<<-EOT
    #!/bin/bash

    cat <<'EOF' >> /etc/ecs/ecs.config
    ECS_CLUSTER=${var.name}
    ECS_CONTAINER_INSTANCE_TAGS=${jsonencode(var.default_tags)}
    EOF
  EOT
  )
  ignore_desired_capacity_changes = true

  network_interfaces = [{
    delete_on_termination       = true
    description                 = "eth0"
    device_index                = 0
    security_groups             = [module.autoscaling_sg.security_group_id]
    associate_public_ip_address = true
  }]

  create_iam_instance_profile = true
  iam_role_name               = var.name
  iam_role_description        = "ECS role for ${var.name}"
  iam_role_policies = {
    AmazonEC2ContainerServiceforEC2Role = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
    AmazonSSMManagedInstanceCore        = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = var.default_tags
}
module "autoscaling_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1"

  name        = var.name
  description = "Autoscaling group security group"
  vpc_id      = data.aws_subnet.subnet.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.alb.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_rules = ["all-all"]

  tags = var.default_tags
}
