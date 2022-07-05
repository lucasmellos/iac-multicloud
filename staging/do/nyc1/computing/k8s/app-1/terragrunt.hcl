
include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../../networking/vpc/default"
}

dependency "global_tags" {
  config_path = "../../../../_common/tags"
}

dependency "local_tags" {
  config_path = "../../../_common/tags"
}

locals {
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

terraform {
  source = "git::git@github.com:lucasmellos/terraform-modules.git//do/kubernetes"
}

inputs = merge(
  local.environment.inputs,
  local.region.inputs,
  {
    cluster_name   = "app"
    sequence       = 1
    node_pool_name = "nodepool-default"
    node_pool_size = "small"
    auto_scale     = true
    node_count     = 3
    vpc_id         = dependency.vpc.outputs.vpc_id
    tags           = merge(dependency.global_tags.outputs.tag_names, dependency.local_tags.outputs.tag_names)
    autoscale_nodes = {
      min_nodes = 3
      max_nodes = 5
    }
})

