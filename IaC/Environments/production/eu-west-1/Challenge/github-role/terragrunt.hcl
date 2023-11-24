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

dependency "ecs" {
  config_path = "../ECS-cluster"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    cluster_name = "fake-cluster"
  }
}

dependency "app" {
  config_path = "../app"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    task_definition_role_arn = "fake-arn"
    task_execution_role_arn  = "fake-arn"
    service_name             = "fake-service"
  }
}

dependencies {
  paths = ["../app", "../ECR", "../ECS-cluster"]
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  ecs_name                 = dependency.ecs.outputs.cluster_name
  task_definition_role_arn = dependency.app.outputs.task_definition_role_arn
  task_execution_role_arn  = dependency.app.outputs.task_execution_role_arn
  service_name             = dependency.app.outputs.service_name
  ecr_arn                  = dependency.ecr.outputs.ecr_arn
  repo_name                = "Daverkex/Lifebit-Challenge"
}
