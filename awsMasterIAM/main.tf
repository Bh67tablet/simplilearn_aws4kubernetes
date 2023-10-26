provider "aws" {
 	region 	= var.ec2_parameters.region
}

resource "aws_instance" "bh67" {
	count = 1
	vpc_security_group_ids 		= ["sg-02a821aed20702149"]
	ami 				= var.ec2_parameters.ami
	instance_type 			= var.ec2_parameters.itype
	subnet_id 			= var.ec2_parameters.subnet
	associate_public_ip_address 	= var.ec2_parameters.publicip
	key_name 			= var.ec2_parameters.keyname
	iam_instance_profile 		= "${aws_iam_instance_profile.test_profile.name}"
	tags = {
	    # The count.index allows you to launch a resource 
	    # starting with the distinct index number 0 and corresponding to this instance.
	    Name = "AnsibleMaster-${count.index}"
  	}
user_data = <<EOF
#! /bin/bash
echo "I was here">/var/tmp/greetings.txt
sudo apt -y update >>/var/tmp/yum.update 2>&1
sudo apt -y install git >>/var/tmp/yum.update 2>&1
sudo apt-get install -y software-properties-common >>/var/tmp/yum.update 2>&1
sudo apt-add-repository ppa:ansible/ansible >>/var/tmp/yum.update 2>&1
sudo apt-get update >>/var/tmp/yum.update 2>&1
sudo apt-get install -y ansible >>/var/tmp/yum.update 2>&1
sudo useradd -m ansiuser -s /bin/bash -p 'ansiuser' >>/var/tmp/yum.update 2>&1                                                                                                                                                    
sudo echo "ansiuser:ansiuser" | chpasswd >>/var/tmp/yum.update 2>&1
sudo cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.bak >>/var/tmp/yum.update 2>&1
sudo cp -p /etc/sudoers /etc/sudoers.bak >>/var/tmp/yum.update 2>&1
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config >>/var/tmp/yum.update 2>&1
sudo sed -i "s/^root.*$/root    ALL=(ALL:ALL) ALL\nansiuser ALL=NOPASSWD: ALL/g" /etc/sudoers >>/var/tmp/yum.update 2>&1
sudo systemctl restart sshd >>/var/tmp/yum.update 2>&1
sudo diff /etc/ssh/sshd_config /etc/ssh/sshd_config.bak >>/var/tmp/yum.update 2>&1
sudo diff /etc/sudoers /etc/sudoers.bak >>/var/tmp/yum.update 2>&1
sudo apt install -y awscli >>/var/tmp/yum.update 2>&1
sudo ansible-galaxy collection install amazon.aws -y >>/var/tmp/yum.update 2>&1
sudo apt install python3-pip -y >>/var/tmp/yum.update 2>&1
echo `hostname -I` > ip_`hostname`.txt
aws ec2 describe-instances --filters 'Name=tag:Name,Values=*' >> ip_`hostname`.txt
aws s3 cp ip_`hostname`.txt s3://bh67-githubactions-bucket/
aws s3 cp s3://bh67-githubactions-bucket/terraform.tfstate .
echo $(grep -w "private_ip".*, terraform.tfstate | cut -d"\"" -f4) >> ips
sudo cp ips /home/ansiuser/ips
sudo chown ansisuer:ansiuser /home/ansiuser/ips
EOF
}