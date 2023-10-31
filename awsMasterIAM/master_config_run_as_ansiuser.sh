#!/usr/bin/env bash
mkdir /home/ansiuser/.ssh
chmod 700 /home/ansiuser/.ssh
ssh-keygen -q -t rsa -f /home/ansiuser/.ssh/id_rsa -N '' <<< $'\ny' >/dev/null 2>&1
echo [webserver] > /home/ansiuser/myinventory
echo $(grep -w "private_ip".*, terraform.tfstate | cut -d"\"" -f4) >> ips
for ip in $(cat /home/ansiuser/ips); do echo $ip >> /home/ansiuser/myinventory; done
cat /home/ansiuser/myinventory
