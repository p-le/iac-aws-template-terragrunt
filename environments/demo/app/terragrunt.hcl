include "root" {
  path = find_in_parent_folders()
}


terraform {
  source = "./../../../modules//app"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "temporary-vpc-id"
  }
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}
