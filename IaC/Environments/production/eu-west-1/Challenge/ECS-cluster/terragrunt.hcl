locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "${get_parent_terragrunt_dir()}/../Modules/ECS/Cluster//"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../Common/VPC"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    private_subnets_ids = ["fake-subnet-1", "fake-subnet-2", "fake-subnet-3"]
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  subnets = dependency.vpc.outputs.private_subnets_ids
  alb_subnets = dependency.vpc.outputs.public_subnets_ids
  name    = "Challenge"
}
