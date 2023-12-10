resource "aws_instance" "myec2" {
  ami           = "ami-0bb4c991fa89d4b9b"
  instance_type = "t2.micro"
  key_name = "simplilearn_key"

  tags = {
    Name = "Instance1"
  }
user_data = <<EOF
#! /bin/bash
echo "I was here">/var/tmp/greetings.txt
sudo apt -y update >>/var/tmp/yum.update 2>&1
# autoinstall
sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
#
sudo apt -y install git >>/var/tmp/yum.update 2>&1
sudo apt-get install -y software-properties-common >>/var/tmp/yum.update 2>&1
sudo apt install -y awscli >>/var/tmp/yum.update 2>&1
echo `hostname -I` > ip_`hostname`.txt
aws ec2 describe-instances --filters 'Name=tag:Name,Values=*' >> ip_`hostname`.txt
sudo su - -c 'su - ec2-user -c "git clone https://github.com/Bh67tablet/simplilearn_aws4kubernetes.git"' >>/var/tmp/yum.update 2>&1
sudo chmod 755 /home/ec2-user/simplilearn_aws4kubernetes/terraform1/*.sh >>/var/tmp/yum.update 2>&1
sudo bash /home/ec2-user/simplilearn_aws4kubernetes/terraform1/alias_to_bash_profiles.sh
sudo wget https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_amd64.zip
sudo yum -y install unzip
sudo unzip terraform_1.6.3_linux_amd64.zip
sudo mv terraform /usr/bin
EOF
  vpc_security_group_ids = [
    aws_security_group.bh67sg.id
  ]
  
  depends_on = [ aws_security_group.bh67sg ]
}
