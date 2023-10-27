# ======================================
# Setup the AWS provider
# ==================================
# Connect to AWS lab and create an IAM user with access key and secret key
# ===================================
# Create
# the terraform configuration file with provider block
# =================================
# configure AWS provider
#
#
aws configure
#
#
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
