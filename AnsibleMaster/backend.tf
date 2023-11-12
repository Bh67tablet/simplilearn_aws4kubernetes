terraform {
  backend "s3" {
    bucket = "bh67-githubactions-bucket"
    key    = "awsAnsible/terraform.tfstate"
    region = "us-east-1"
  }
}
