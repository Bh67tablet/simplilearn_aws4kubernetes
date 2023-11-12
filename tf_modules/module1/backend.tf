terraform {
  backend "s3" {
    bucket = "bh67_S3_Bucket"
    key = "global/terraform.tfstate"
    region = "us-east-1"
  }
}
