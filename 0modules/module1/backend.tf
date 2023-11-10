terraform {
  backend "s3" {
    bucket = "bucket-name"
    key    = "dev/vpc/main/terraform.tfstate"
    region = "us-east-1"
  }
}
