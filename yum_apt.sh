#!/bin/bash

install_ubuntu() {
	# autoinstall
	sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
 	#
	sudo apt -y update
	sudo apt -y install unzip
 	sudo apt -y install bzip2
	sudo apt -y install git
 	sudo apt -y install expect
	sudo wget https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_amd64.zip
	sudo unzip terraform_1.6.3_linux_amd64.zip
	sudo mv terraform /usr/bin
  	sudo su - -c 'su - ubuntu -c "git clone https://github.com/Bh67tablet/Complete-Python-3-Bootcamp.git"' >>/var/tmp/ansiuser.log 2>&1
	exit 0
}

install_centos() {
	sudo yum -y update
	sudo yum -y install unzip
	sudo yum -y install git
	sudo wget https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_amd64.zip
	sudo unzip terraform_1.6.3_linux_amd64.zip
	sudo mv terraform /usr/bin
	exit 0
}
################ MAIN ###################

if [ -f /etc/os-release ];then
   osname=`grep ID /etc/os-release | egrep -v 'VERSION|LIKE|VARIANT|PLATFORM' | cut -d'=' -f2 | sed -e 's/"//' -e 's/"//'`
   echo $osname
   if [ $osname == "ubuntu" ];then
       install_ubuntu
   elif [ $osname == "amzn" ];then
       install_centos
   elif [ $osname == "centos" ];then
       install_centos
  fi
else
   echo "can not locate /etc/os-release - unable find the osname"
   exit 8
fi
exit 0
