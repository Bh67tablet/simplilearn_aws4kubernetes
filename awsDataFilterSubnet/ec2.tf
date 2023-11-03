provider "aws" {
  region  = "us-east-1"
  
}

resource "aws_instance" "ec2-ubuntu" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnet.get-subnet-id.id
  key_name               = "simplilearn_key"

  tags = {
    Name = "Ubuntu-1"
    }
}
