provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "ec2" {
  ami                    = "ami-03e08697c325f02ab"
  instance_type          = "t2.micro"
  key_name               = "bh67"
  vpc_security_group_ids = ["sg-0d9ad20eb37abbdac"]
  subnet_id              = "subnet-00778ba4eab978eb7"
user_data = <<EOF
#! /bin/bash
echo "I was here">/var/tmp/greetings.txt
sudo apt -y update >>/var/tmp/yum.update 2>&1
sudo apt -y install postgresql postgresql-contrib >>/var/tmp/yum.update 2>&1
sudo cp /etc/postgresql/14/main/postgresql.conf /etc/postgresql/14/main/postgresql.conf.backup
sudo sudo sed -i "/^#listen_addresses/a listen_addresses = '\*'" /etc/postgresql/14/main/postgresql.conf
sudo cp /etc/postgresql/14/main/pg_hba.conf /etc/postgresql/14/main/pg_hba.conf.backup
sudo su postgres -c 'echo "host all all 0.0.0.0/0 trust" >> /etc/postgresql/14/main/pg_hba.conf'
sudo systemctl start postgresql.service
EOF

  tags = {
    Terraform       = "true"
    Environment     = "SANDBOX"
    ManagedBy       = "firstname.lastname@vodafone.com"
    SecurityZone    = "I-A"
    Project         = "Sandbox"
    Confidentiality = "C2"
    TaggingVersion  = "V2.4"
    Name            = "ec2-simple"
  }
  
  root_block_device {
    tags = {
    Terraform       = "true"
    Environment     = "SANDBOX"
    ManagedBy       = "firstname.lastname@vodafone.com"
    SecurityZone    = "I-A"
    Project         = "Sandbox"
    Confidentiality = "C2"
    TaggingVersion  = "V2.4"
    Name            = "ec2-simple"
    }
  }
}
