
include {
  path = find_in_parent_folders()
}

dependency "cocre" {
  config_path = "../../projects/cocre"
}

dependency "nyc1_cocre" {
  config_path = "../../../nyc1/computing/k8s/cocre-1"
}

terraform {
  source = "git::git@github.com:lucasmellos/terraform-modules.git//do/project_resources"
}

inputs = {
  project_id = dependency.cocre.outputs.project_id,
  resources = [dependency.nyc1_cocre.outputs.cluster_urn]
}
