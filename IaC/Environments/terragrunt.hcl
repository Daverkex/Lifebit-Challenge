locals {
  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  region      = local.region_vars.locals.aws_region
  environment = local.environment_vars.locals.environment

  tfstate_region = "eu-west-1"
  profile        = "default"
}

generate "providers" {
  path      = "providers_generated.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "${local.region}"

  profile = "${local.profile}"
}
EOF
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "sought-phoenix-4g1r"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.tfstate_region
    encrypt        = true
    dynamodb_table = "terraform-tfstates-lock"
  }
}

inputs = {
  default_tags = {
    creator     = "Terraform"
    environment = local.environment
  }
}
