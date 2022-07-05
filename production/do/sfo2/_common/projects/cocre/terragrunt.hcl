
include {
  path = find_in_parent_folders()
}

locals {

  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
}

terraform {
  source = "git::git@github.com:lucasmellos/terraform-modules.git//do/project"
}

inputs = merge(
  local.environment.inputs,
  {
    name        = "STG SFO2 Commmon Core"
    description = "Common Core resources"
    purpose     = "Provide resources for devs and production environment"
})
