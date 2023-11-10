resource "aws_s3_bucket" "example" {
  bucket = bucket-name"

  tags = {
    Name        = "bh67"
    Environment = "dev"
  }
}
