output "cluster_arn" {
  value       = module.ecs_cluster.arn
  description = "The cluster ARN"
}

output "cluster_name" {
  value       = module.ecs_cluster.name
  description = "The cluster name"
}

output "capacity_provider_name" {
  value       = module.ecs_cluster.autoscaling_capacity_providers["one"].name
  description = "The capacity provider name"
}

output "target_group_arn" {
  value       = module.alb.target_groups["ex_ecs"].arn
  description = "The load balancer target group ARN binded to this cluster"
}
