resource "aws_instance" "ec2worker" {
	count = 2
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "simplilearn_key"
  subnet_id = data.terraform_remote_state.global.outputs.lambda_subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.global.outputs.tls_security_group_id]
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
EOF
