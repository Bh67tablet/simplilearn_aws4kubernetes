# =======================================
# Terraform:
# =================================================
# Download and setup terraform on MASTER NODE:
# ===========================================
# https://developer.hashicorp.com/terraform/downloads
sudo su -
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
terraform –version
# ======================================
# Setup the AWS provider
# ==================================
# Connect to AWS lab and create an IAM user with access key and secret key
# ===================================
# Create
# the terraform configuration file with provider block
# =================================
# configure AWS provider
mkdir myterraformfiles
cd myterraformfiles
cat > provider_aws.tf << EOF
provider "aws" {
  region = "us-east-1"
  access_key = "AKIAUJU24ZR3TN4HE23O"
  secret_key = "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"
}
EOF
#
aws configure
#
ls ~/.aws
cat > $HOME/myterraformfiles/provider_aws.tf << EOF
provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
}
EOF
terraform init
sudo apt-get update
sudo apt  install awscli
# Demo 3: EC2 resource creation using terraform:
# Add the below code in the existing procider_aws.tf file.
cat >> provider_aws.tf << EOF
resource "aws_instance" "myec2" {
  ami           = "ami-0bb4c991fa89d4b9b"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance1"
  }
}
EOF
terraform apply --auto-approve
# Give yes
# It will create the resource on AWS
# ===================================
# Demo 4: Data block to pass filtered data to the resource block

# data block will filter data and pass it on to the resoruce block

cat >> provider_aws.tf << EOF
data "aws_ami" "my-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.my-ami.id
  instance_type = "t2.micro"

  tags = {
    Name = "Instance1"
  }
}
EOF
# terraform apply --auto-approve
# Give yes for approval
# AWS instance will be created.
# ========================================
# Demo 5: Create a new resource block for elastic Ip in AWS
cat > eip_aws.tf << EOF
resource "aws_eip" "myeip" {
  vpc = true
}
EOF
terraform apply -auto-approve
# Associate this elastic ip to the existing Ec2 instance
# ==========================================
# In the same file eip_aws.tf add the below association:
cat >> eip_aws.tf << EOF
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id
  allocation_id = aws_eip.myeip.id
}
EOF
terraform apply -auto-approve
#Output block to print attribute values upon creation of resource:
cat > output-demo.tf << EOF

output "eipvalue" {

value = aws_eip.myeip.public_ip 
}

output "eipallocationid" {

value = aws_eip.myeip.allocation_id

}

output "aws_instance_status"{ 

value = aws_instance.myec2.instance_state

}

output "aws_instance_publicip" {

value = aws_instance.myec2.public_ip
}
EOF
terraform apply --auto-approve
#===================================
mkdir variable-demo
cd variable-demo
cat > variables.tf << EOF

variable "access_key"{

default = "AKIAUJU24ZR36YGWPS3D"

}

variable "secret_key" {

default = "37a4jeARDewK7EDBVzpLfvZni/gv5dq+iSYmYfGE"

}

variable "ami" {

default = "ami-0261755bbcb8c4a84"

}

variable "instance_type" {

default = "t2.micro"

}
EOF
#
cat > aws_variable.tf << EOF
provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "myec2" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "Instance1"
  }
}
EOF
terraform plan --auto-approve

cat > terraform.tfvars << EOF
Instance_type = “t2.large”
EOF
terraform plan --auto-approve
