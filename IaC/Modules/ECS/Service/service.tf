module "ecs_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"
  version = "~> 5.7"

  name        = var.name
  cluster_arn = var.cluster_arn

  autoscaling_max_capacity = 2

  cpu    = var.cpu
  memory = var.memory
  requires_compatibilities = ["EC2"]
  capacity_provider_strategy = {
    # On-demand instances
    one = {
      capacity_provider = var.capacity_provider_name
      weight            = 1
      base              = 1
    }
  }

  subnet_ids = var.alb_subnets
  network_mode = "bridge"
  container_definitions = {
    app = {
      cpu       = var.cpu
      memory    = var.memory
      essential = true
      image     = var.container_image
      port_mappings = [
        {
          name = "app"
          containerPort = 3000
          protocol = "tcp"
        }
      ]
    }
  }

  load_balancer = {
    service = {
      target_group_arn = var.target_group_arn
      container_name   = var.container_name
      container_port   = var.container_port
    }
  }

  security_group_rules = {
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
