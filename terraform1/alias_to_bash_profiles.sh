#!/bin/bash
cat > /home/ec2-user/.bash_profiles << EOF
alias ti='terraform init'
alias tp='terraform plan'
alias ta='terraform apply --auto-approve'
alias td='terraform destroy  --auto-approve'
EOF
