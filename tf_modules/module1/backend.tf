terraform {
  backend "s3" {
    bucket = "bh67"
    key = "tf_modules/module1/terraform.tfstate"
    region = "us-east-1"
  }
}
