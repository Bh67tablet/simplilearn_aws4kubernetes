data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "bh67"
    key	   = "global/terraform.tfstate"
    region = "us-east-1"
  }
}

terraform {
  backend "s3" {
    bucket = "bh67"
    key = "worker/terraform.tfstate"
    region = "us-east-1"
  }
}
