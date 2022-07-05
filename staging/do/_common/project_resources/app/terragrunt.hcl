
include {
  path = find_in_parent_folders()
}

dependency "app" {
  config_path = "../../projects/app"
}

dependency "nyc1_app1" {
  config_path = "../../../nyc1/computing/k8s/app-1"
}

terraform {
  source = "git::git@github.com:lucasmellos/terraform-modules.git//do/project_resources"
}

inputs = {
  project_id = dependency.app.outputs.project_id,
  resources = [dependency.nyc1_app1.outputs.cluster_urn]
}
