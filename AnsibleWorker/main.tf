provider "aws" {
 	region 	= var.ec2_parameters.region
}

resource "aws_instance" "bh67" {
	count = 2
	ami 				= var.ec2_parameters.ami
	instance_type 			= var.ec2_parameters.itype
	subnet_id 			= var.subnet_id
	associate_public_ip_address 	= var.ec2_parameters.publicip
	key_name 			= var.ec2_parameters.keyname
	iam_instance_profile   		= var.ec2_parameters.iam_instance_profile
	tags = {
	    # The count.index allows you to launch a resource 
	    # starting with the distinct index number 0 and corresponding to this instance.
	    Name = "Ansible-${count.index}"
  	}
}
