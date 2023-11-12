data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "bh67"
    key	   = "global/terraform.tfstate"
    region = "us-east-1"
  }
}
