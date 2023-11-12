terraform {
  backend "s3" {
    bucket = "bh67_S3_Bucket"
    key = "tf_modules/module1/terraform.tfstate"
    region = "us-east-1"
  }
}