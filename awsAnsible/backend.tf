terraform {
  backend "s3" {
    bucket = "bh67-githubactions-bucket"
    key    = "awsAnsible/terraform.tfstate"
    region = "us-east-1"
  }
}

#### refering the vpc (resource-1) remote backend
data "terraform_remote_state" "vpc_subnets_ids" {
  backend = "s3"

  config = {
    bucket = "bh67-githubactions-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
