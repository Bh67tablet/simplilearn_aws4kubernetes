terraform {
  backend "s3" {
    bucket = "bh67-githubactions-bucket"
    key = "global/terraform.tfstate"
    region = "us-east-1"
  }
}
 
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
 
resource "aws_subnet" "lambda" {
  vpc_id 	= aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}
 
resource "aws_security_group" "allow_tls" {
  name    	= "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id  	= aws_vpc.main.id
 
  ingress {
    description  	= "TLS from VPC"
    from_port    	= 443
    to_port      	= 443
    protocol     	= "tcp"
    cidr_blocks  	= [aws_vpc.main.cidr_block]
  }
 
  egress {
    from_port    	= 0
    to_port      	= 0
    protocol     	= "-1"
    cidr_blocks  	= ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
 
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
 
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
 
resource "aws_iam_role_policy_attachment" "lambda_role_vpc_execution" {
  role = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
