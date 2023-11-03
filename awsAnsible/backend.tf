terraform {
  backend "s3" {
    bucket = "bh67-githubactions-bucket"
    key    = "master/terraform.tfstate"
    region = "us-east-1"
  }
}
