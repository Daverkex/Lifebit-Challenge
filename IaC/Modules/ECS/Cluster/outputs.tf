output "cluster_arn" {
  value = module.ecs_cluster.arn
}

output "cluster_name" {
  value = module.ecs_cluster.name
}

output "capacity_provider_name" {
  value = module.ecs_cluster.autoscaling_capacity_providers["one"].name
}

output "target_group_arn" {
  value = module.alb.target_groups["ex_ecs"].arn
}
