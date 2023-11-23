module "ecs_cluster" {
  source  = "terraform-aws-modules/ecs/aws//modules/cluster"
  version = "~> 5.7"

  cluster_name = var.name

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }
    }
  }

  autoscaling_capacity_providers = {
    one = {
      auto_scaling_group_arn = module.autoscaling.autoscaling_group_arn
    }
  }

  tags = var.default_tags
}