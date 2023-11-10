resource "aws_s3_bucket" "example" {
  bucket = bucket-name"

  tags = {
    Name        = "bh67"
    Environment = "Dev"
  }
}

terraform {
  backend "s3" {
    bucket = "bucket-name"
    key    = "dev/vpc/main/terraform.tfstate"
    region = "us-east-1"
  }
}
