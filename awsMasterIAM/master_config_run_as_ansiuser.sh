#!/usr/bin/env bash
sudo -s <<ROOT
echo `whoami` > /home/ansiuser/hallo.txt
#
sudo -i -u ansiuser bash << EOF
echo `whoami` > /home/ansiuser/hallo_ansiuser.txt
mkdir /home/ansiuser/.ssh
chmod 700 /home/ansiuser/.ssh
ssh-keygen -q -t rsa -f /home/ansiuser/.ssh/id_rsa -N '' <<< $'\ny' >/dev/null 2>&1
echo [webserver] > /home/ansiuser/myinventory
for ip in $(cat /home/ansiuser/ips); do echo $ip >> /home/ansiuser/myinventory; done
EOF
#
cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bak
cat > /etc/ansible/ansible.cfg << EOF
[defaults]
inventory = /home/ansiuser/myinventory
EOF
diff /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bak
echo `whoami` > /home/ansiuser/hallo.txt
ROOT
#for ip in $(cat /home/ansiuser/ips); do echo "sshpass -p ansiuser ssh-copy-id -i $HOME/.ssh/id_rsa.pub ansiuser@$ip"; done
echo "run the following commands: (did not run in script)"
for ip in $(cat /home/ansiuser/ips); do echo "ssh-copy-id -i $HOME/.ssh/id_rsa.pub ansiuser@$ip"; done
