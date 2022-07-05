
remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket  = "my-tfstate"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-2"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}
