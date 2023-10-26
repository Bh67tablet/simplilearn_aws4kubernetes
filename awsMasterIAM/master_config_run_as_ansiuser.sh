#!/bin/bash
#
# run as user: ansiuser !!!
#

#master:
#--------


#su – ansiuser
mkdir /home/ansiuser/.ssh
chmod 700 /home/ansiuser/.ssh
ssh-keygen -q -t rsa -f /home/ansiuser/.ssh/id_rsa -N '' <<< $'\ny' >/dev/null 2>&1
for ip in $(cat /home/ansiuser/ips); do echo ssh-copy-id -i $HOME/.ssh/id_rsa.pub ansiuser@$ip; done
#ssh-copy-id -i $HOME/.ssh/id_rsa.pub ansiuser@172.31.13.160

echo [webserver] > /home/ansiuser/myinventory
for ip in $(cat /home/ansiuser/ips); do echo $ip >> /home/ansiuser/myinventory; done

ansible -i /home/ansiuser/myinventory webserver -m ping

sudo cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bak
sudo cat > /etc/ansible/ansible.cfg << EOF
[defaults]
inventory = /home/ansiuser/myinventory
EOF
sudo diff /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bak

ansible webserver -m ping
ansible webserver -m command -a "free -h"
ansible webserver -m command -a "whoami"
ansible webserver -m file -a "name=/tmp/testdir state=directory"
ansible webserver -m command -a "ls -al /tmp"
ansible webserver -m file -a "name=/tmp/testdir state=absent"
ansible webserver -m file -a "name=/tmp/testfile state=touch"
ansible webserver -m file -a "name=/tmp/testfile state=absent"
