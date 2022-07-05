
include {
  path = find_in_parent_folders()
}

locals {

  region      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
}

terraform {
  source = "git::git@github.com:lucasmellos/terraform-modules.git//do/vpc"
}

inputs = merge(
  local.region.inputs,
  local.environment.inputs,
  {
    vpc_name   = "common"
    cidr_block = "10.1.0.0/16"
    sequence   = 1
})
