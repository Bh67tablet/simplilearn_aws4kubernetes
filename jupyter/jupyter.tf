provider "aws" {
 	region 	= "us-east-1"
}

resource "aws_instance" "ec2" {
	count = 1
	ami 				= "ami-0fc5d935ebf8bc3bc"
	instance_type 		= "t2.medium"
	key_name 			= "bh67.pem"
	associate_public_ip_address 	= "true"
	tags = {
	    Name = "KubernetesMaster-${count.index}"
  	}
user_data = <<EOF
#/bin/bash!
sudo yum -y install bzip2
sudo yum -y install git
sudo su - -c 'su - ec2-user -c "echo PATH=$PATH:/home/ec2-user/anaconda3/bin >> ~/.bash_profile"'
sudo su - -c 'su - ec2-user -c "git clone https://github.com/Bh67tablet/Complete-Python-3-Bootcamp.git"'
sudo chmod u+x /home/ec2-user/Complete-Python-3-Bootcamp/*.sh
sudo su - -c 'su - ec2-user -c "source ~/.bashrc & /home/ec2-user/Complete-Python-3-Bootcamp/install_jupyter_notebook_amazon.sh"'
EOF
  vpc_security_group_ids = [ aws_security_group.bh67sg.id ]
  depends_on = [ aws_security_group.bh67sg ]
}


resource "aws_security_group" "bh67sg" {
 	vpc_id 		= "vpc-0963daf76a92fc144"

  // ssh, https, rdp, postgres
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 8888
    protocol = "tcp"
    to_port = 8888
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
