#!/bin/bash
whoami
echo "I was here"
apt -y update
apt -y install git
apt-get install -y software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install -y ansible
useradd -m ansiuser -s /bin/bash -p 'ansiuser'
echo "ansiuser:ansiuser" | chpasswd
cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
cp -p /etc/sudoers /etc/sudoers.bak
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i "s/^root.*$/root    ALL=(ALL:ALL) ALL\nansiuser ALL=NOPASSWD: ALL/g" /etc/sudoers
systemctl restart sshd
diff /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
diff /etc/sudoers /etc/sudoers.bak
apt install -y awscli
ansible-galaxy collection install amazon.aws -y
apt install python3-pip -y
#
cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bak
cat > /etc/ansible/ansible.cfg << EOF
[defaults]
inventory = /home/ansiuser/myinventory
EOF
diff /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bak
cat /etc/ansible/ansible.cfg
#
wget https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_amd64.zip
apt install unzip -y
unzip terraform_1.6.3_linux_amd64.zip
mv terraform /usr/bin
