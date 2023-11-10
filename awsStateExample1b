data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "centraldeploymentstate"
    key	   = "global/terraform.tfstate"
    region = "eu-central-1"
  }
}
