# simplilearn_aws
aws

1. secrets: im repository anpassen
2. variables: vpc und subnet id aktuallisieren
3. simplilearn_key erstellen
4. run: .github/workflows/Ansible.yml
- iam
- s3
- AnsibleWorker
- AnsibleMaster

5. bash: ./master_playbooks_run_as_ansiuser.sh
on AnsibleMaster:
ansiuser@ip:~/simplilearn_aws/AnsibleMaster

## Jenkins
run install script on AnsibleMaster-0:
./install_jenkins.sh

![1](./jenkins_on_aws_gui_ssh_tunnel_to_lolocalhost_port_8081.png)

## DevOps Certification Training - Enterprise
### Automating Infrastructure using Terraform .

Course-end Project 1
Description
Use Terraform to provision infrastructure

Description:
Nowadays, infrastructure automation is critical. We tend to put the most emphasis on software development processes, but infrastructure deployment strategy is just as important. Infrastructure automation not only aids disaster recovery, but it also facilitates testing and development.

Your organization is adopting the DevOps methodology and in order to automate provisioning of infrastructure there's a need to setup a centralised server for Jenkins.

Terraform is a tool that allows you to provision various infrastructure components. Ansible is a platform for managing configurations and deploying applications. It means you'll use Terraform to build a virtual machine, for example, and then use Ansible to instal the necessary applications on that machine.

Considering the Organizational requirement you are asked to automate the infrastructure using Terraform first and install other required automation tools in it.
Tools required: Terraform, AWS account with security credentials, Keypair

Expected Deliverables:
Launch an EC2 instance using Terraform
Connect to the instance
Install Jenkins, Java and Python in the instance

### Work
My Public Repository:
https://github.com/Bh67tablet/simplilearn_aws.git

use Actions secrets and variables vor aws secrets, vpc and subnet_id

My Workflow to run Terraform init, apply and destroy IAM Role, S3, Ansible Worker and Master:
.github/workflows/Ansible.yml

Terraform Directory's:
AnsibleIam
AnsibleS3
AnsibleWorker
AnsibleMaster

- git clone my Repository to Ansible Master
- Install script for Jenkins in Anisble Master
- Script to create and run my Ansible Playbooks in Directory AnsibleMaster

Ready to Configure Jenkins Plugins, Job and Secret. Edit dev.inv change actual Worker IPv4's.

Run Jenkins Job that run Ansible Playbooks to install Java and Python on "Ansible Workers".

#### Questions:
How to import vpc, subnet_id from aws to my terraform State? To use to create sec group and worker ec2?
