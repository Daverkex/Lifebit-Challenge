locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "${get_parent_terragrunt_dir()}/../Modules/github-credentials/role//"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "ecr" {
  config_path = "../ECR"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    ecr_arn = "fake-ecr-arn"
  }
}

dependencies {
  paths = ["../ECR"]
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  ecr_arn   = dependency.ecr.outputs.ecr_arn
  repo_name = "Daverkex/Lifebit-Challenge"
}
