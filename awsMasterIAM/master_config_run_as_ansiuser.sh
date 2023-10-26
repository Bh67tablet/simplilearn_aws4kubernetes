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
for ip in $(cat ips); do echo ssh-copy-id -i $HOME/.ssh/id_rsa.pub ansiuser@$ip; done
#ssh-copy-id -i $HOME/.ssh/id_rsa.pub ansiuser@172.31.13.160

sudo su -

# cp -p /etc/ansible/hosts /etc/ansible/hosts.bak
# cat > /etc/ansible/hosts << EOF
# [worker1]
# 172.31.7.96

# [worker2]
# 172.31.10.99

# [webserver]
# 172.31.7.96
# 172.31.10.99
# EOF
# diff /etc/ansible/hosts /etc/ansible/hosts.bak


# cat > /home/ansiuser/myinventory << EOF
# [webserver]
# 192.168.0.225
# EOF

echo [webserver] > /home/ansiuser/myinventory
for ip in $(cat ips); do echo $ip >> /home/ansiuser/myinventory; done

ansible -i /home/ansiuser/myinventory webserver -m ping

cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bak
cat > /etc/ansible/ansible.cfg << EOF
[defaults]
inventory = /home/ansiuser/myinventory
EOF
diff /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bak

ansible webserver -m ping
ansible webserver -m command -a "free -h"
ansible webserver -m command -a "whoami"
ansible webserver -m file -a "name=/tmp/testdir state=directory"
ansible webserver -m command -a "ls -al /tmp"
ansible webserver -m file -a "name=/tmp/testdir state=absent"
ansible webserver -m file -a "name=/tmp/testfile state=touch"
ansible webserver -m file -a "name=/tmp/testfile state=absent"