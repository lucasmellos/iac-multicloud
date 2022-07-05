
include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:lucasmellos/terraform-modules.git//do/tag"
}

inputs = (
  {
    tags = ["region:sfo2"]
  }
)
