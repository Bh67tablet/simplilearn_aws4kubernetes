resource "aws_instance" "ec2" {
  ami                    = var.ec2_parameters.ami
  instance_type          = var.ec2_parameters.instance_type
  vpc_security_group_ids = var.ec2_parameters.vpc_security_group_ids
  subnet_id              = data.terraform_remote_state.landingzone_statefile.outputs.priv_net[0]
  iam_instance_profile   = var.ec2_parameters.iam_instance_profile
user_data = <<EOF
#! /bin/bash
echo "I was here">/var/tmp/greetings.txt
yum -y update >>/var/tmp/yum.update 2>&1
yum -y install httpd >>/var/tmp/yum.httpd 2>&1
systemctl start httpd >>/var/tmp/http.start 2>&1
systemctl status httpd >>/var/tmp/http.status 2>&1
EOF
  
  tags = merge(
    var.tags
  )
  
  root_block_device {
    tags = merge(
    var.tags
    )
  }
}
