provider "aws" {
 	region 	= var.ec2_parameters.region
}

resource "aws_instance" "awsAnsible" {
	count = 1
	ami 				= var.ec2_parameters.ami
	instance_type 			= var.ec2_parameters.itype
	subnet_id 			= var.subnet_id
	associate_public_ip_address 	= var.ec2_parameters.publicip
	key_name 			= var.ec2_parameters.keyname
	iam_instance_profile   		= var.ec2_parameters.iam_instance_profile
	vpc_security_group_ids 		= ["sg-0e2bcfcbd5ed2a965"]
	tags = {
	    # The count.index allows you to launch a resource 
	    # starting with the distinct index number 0 and corresponding to this instance.
	    Name = "awsAnsibleAuto-${count.index}"
  	}
user_data = <<EOF
#! /bin/bash
sudo sh /home/ansiuser/simplilearn_aws/master_config_run_as_root.sh >>/var/tmp/yum.update 2>&1
sudo su - -c 'su - ansiuser -c "git clone https://github.com/Bh67tablet/simplilearn_aws.git"' >>/var/tmp/yum.update 2>&1
sudo chmod 755 /home/ansiuser/simplilearn_aws/*.sh >>/var/tmp/yum.update 2>&1
sudo su - -c 'su - ansiuser -c /home/ansiuser/simplilearn_aws/master_config_run_as_ansiuser.sh' >>/var/tmp/yum.update 2>&1
EOF
}
