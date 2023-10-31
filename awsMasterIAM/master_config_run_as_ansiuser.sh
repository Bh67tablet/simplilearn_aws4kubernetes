#!/usr/bin/env bash
echo [webserver] > /home/ansiuser/myinventory
echo $(grep -w "private_ip".*, terraform.tfstate | cut -d"\"" -f4) >> ips
for ip in $(cat /home/ansiuser/ips); do echo $ip >> /home/ansiuser/myinventory; done
cat /home/ansiuser/myinventory
mkdir /home/ansiuser/.ssh
chmod 700 /home/ansiuser/.ssh
ssh-keygen -q -t rsa -f /home/ansiuser/.ssh/id_rsa -N '' <<< $'\ny' >/dev/null 2>&1
#for ip in $(cat /home/ansiuser/ips); do sshpass -p ansiuser ssh-copy-id -i $HOME/.ssh/id_rsa.pub ansiuser@$ip; done
for ip in $(cat /home/ansiuser/ips); do echo "ssh-copy-id -i $HOME/.ssh/id_rsa.pub ansiuser@$ip"; done
for ip in $(cat /home/ansiuser/ips); do echo "ssh -i $HOME/.ssh/id_rsa.pub ansiuser@$ip"; done
echo "run above commands"
echo "for ip in $(cat /home/ansiuser/ips); do ssh ansiuser@$ip ls -la $HOME/.ssh; done"
echo "for ip in $(cat /home/ansiuser/ips); do ssh ansiuser@$ip cat $HOME/.ssh/authorized_keys; done"
