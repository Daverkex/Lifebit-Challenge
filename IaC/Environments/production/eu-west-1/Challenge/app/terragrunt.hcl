locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "${get_parent_terragrunt_dir()}/../Modules/ECS/Service//"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "ecs" {
  config_path = "../ECS-cluster"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    cluster_arn = "fake-arn"
  }
}

dependency "vpc" {
  config_path = "../../Common/VPC"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    public_subnets_ids = ["fake-subnet-1", "fake-subnet-2", "fake-subnet-3"]
  }
}

dependencies {
  paths = ["../ECS-cluster"]
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name    = "challenge-app"
  cluster_arn = dependency.ecs.outputs.cluster_arn
  target_group_arn = dependency.ecs.outputs.target_group_arn
  capacity_provider_name = dependency.ecs.outputs.capacity_provider_name
  alb_subnets = dependency.vpc.outputs.public_subnets_ids
  cpu = 512
  memory = 256
  container_name = "app"
  container_image = "791727025417.dkr.ecr.eu-west-1.amazonaws.com/challenge:2388d4ebc1e4ceb2956ae603848063d72b31b76b"
  container_port = 3000
}
