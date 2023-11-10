terraform {
  backend "s3" {
    bucket = "bh67-githubactions-bucket"
    key    = "awsAnsible/terraform.tfstate"
    region = "us-east-1"
  }
}
# worker remote state file:
data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "centraldeploymentstate"
    key	   = "terraform.tfstate"
    region = "eu-central-1"
  }
}
