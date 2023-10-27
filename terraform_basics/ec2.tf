data "aws_ami" "my-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.my-ami.id
  instance_type = "t2.micro"

  tags = {
    Name = "Instance1"
  }
}
