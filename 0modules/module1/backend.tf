terraform {
  backend "s3" {
    bucket = "bh67"
    key    = "dev/vpc/main/terraform.tfstate"
    region = "us-east-1"
  }
}
