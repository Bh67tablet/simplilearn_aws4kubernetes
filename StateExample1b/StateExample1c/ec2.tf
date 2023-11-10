resource "aws_instance" "ec2" {
  ami                    = "ami-03e08697c325f02ab"
  instance_type          = "t2.micro"
  key_name               = "bh67"
  vpc_security_group_ids = ["sg-0d9ad20eb37abbdac"]
  subnet_id              = "subnet-00778ba4eab978eb7"
}
