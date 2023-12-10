resource "aws_security_group" "bh67sg" {
 	name 		= var.ec2_parameters.secgroupname
 	description 	= var.ec2_parameters.secgroupname
 	vpc_id 		= var.vpc_id

  // ssh, https, rdp, postgres
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
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
