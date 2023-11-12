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
 
  // ssh, https, rdp, postgres
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 3389
    protocol = "tcp"
    to_port = 3389
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 5432
    protocol = "tcp"
    to_port = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
