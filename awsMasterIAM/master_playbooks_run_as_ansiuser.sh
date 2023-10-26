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
# Alternative1:
#
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

#Alternative2
#
# cat > /home/ansiuser/myinventory << EOF
# [webserver]
# 192.168.0.225
# EOF

echo [webserver] > /home/ansiuser/myinventory
for ip in $(cat ips); do echo $ip >> /home/ansiuser/myinventory; done

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

cat > playbookdebug.yml << EOF
- hosts: webserver
  tasks:
  - name: Print a message on hostserver
    debug: msg="Welcome to Ansible Playbook"
EOF

ansible-playbook playbookdebug.yml --syntax-check
ansible-playbook playbookdebug.yml

cat > playbookregister.yml << EOF
- hosts: webserver
  tasks:
  - name: Execute a command on the host
    command: hostname -s
    register: hostname_output
  - name: show  the hostname_output
    debug:
     var: hostname_output
EOF

ansible-playbook playbookregister.yml

ansible webserver -m setup
ansible webserver -m setup | wc -l
ansible webserver -m setup -a "filter=ansible_memfree_mb"
ansible webserver -m setup -a "filter=ansible_mem*"

cat > playbookdebugVar.yml << EOF
- hosts: webserver
  tasks:
  - name: Show Ipaddress of the host servers
    debug:
     msg="The ipaddress of host server  is {{ansible_default_ipv4.address}}"
  - name: print variable
    debug:
     var=ansible_default_ipv4.address
EOF

ansible-playbook playbookdebugVar.yml

cat > playbookwhen.yml << EOF
- hosts: webserver
  tasks:
  - name: Execute a command on the host
    command: hostname -s
    when: (ansible_distribution == "CentOS" and ansible_distribution_major_version == "8") or
          (ansible_distribution == "Ubuntu" and ansible_distribution_major_version == "20")
    register: hostname_output
  - name: show  the hostname_output
    debug:
     var: hostname_output.stdout
EOF

ansible-playbook playbookwhen.yml

cat > playbookloop.yml << EOF
- hosts: webserver
  become: true
  become_user: root
  tasks:
  - name: update apt cache
    apt: update_cache=yes cache_valid_time=3600
  - name: Install packages on the host servers
    package: name={{item}} state=present
    loop:
     - apache2
     - mysql-server
     - php-mysql
     - php
     - libapache2-mod-php
     - python3-mysqldb
EOF

ansible-playbook playbookloop.yml

cat > playbookloop2.yml << EOF
- hosts: webserver
  become: true
  become_user: root
  vars:
   user_list:
    - user01
    - user02
    - user03
  tasks:
  - name: update apt cache
    apt: update_cache=yes cache_valid_time=3600
  - name: Install packages on the host servers
    package: name={{item}} state=present
    loop:
     - apache2
     - mysql-server
     - php-mysql
     - php
     - libapache2-mod-php
     - python3-mysqldb
  - name: Create users on host servers
    user: name={{item}} state=present
    loop: "{{user_list}}"
EOF

ansible-playbook playbookloop2.yml

cat > playbooktags.yml << EOF
- hosts: webserver
  become: true
  tasks:
  - name: update apt-cache
    apt: update_cache=yes cache_valid_time=3600
    tags: install
  - name: install package for LAMP architecture
    package: name={{item}} state=present
    loop:
     - mysql-server
     - php-mysql
    tags: install
  - name: Create a directory on worker nodes
    file: path=/tmp/mydir state=directory
    tags: mydir
  - name: Create a file in the directory
    file: path=/tmp/sonal state=touch
    tags: myfile
EOF

ansible-playbook playbooktags.yml --tags=install
ansible-playbook playbooktags.yml --tags=install,mydir
ansible-playbook playbooktags.yml --skip-tags=install,mydir
ansible-playbook playbooktags.yml --tags untagged
ansible-playbook playbooktags.yml --tags tagged