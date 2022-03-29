locals {
  common_vars = yamldecode(file("common_vars.yaml"))
  environment = split("/", path_relative_to_include())[0]
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = local.common_vars.remote_s3_bucket
    key            = "${local.common_vars.service}/${path_relative_to_include()}/terraform.tfstate"
    region         = local.common_vars.region
    encrypt        = true
    dynamodb_table = "terragrunt-terraform-locks"
  }
}

inputs = {
  region      = local.common_vars.region
  service     = local.common_vars.service
  environment = local.environment
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment
      Region      = var.region
      Service     = var.service
    }
  }
}
EOF
}
