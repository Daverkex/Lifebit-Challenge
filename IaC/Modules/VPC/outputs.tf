output "public_subnets_ids" {
  value       = module.vpc.public_subnets
  description = "The public subnets"
}

output "private_subnets_ids" {
  value       = module.vpc.private_subnets
  description = "The private subnets"
}
