resource "aws_instance" "ec2" {
  ami                    = "ami-03e08697c325f02ab"
  instance_type          = "t2.micro"
  key_name               = "bh67"
  subnet_ids     	       = [data.terraform_remote_state.global.outputs.lambda_subnet_id]
  security_group_ids     = [data.terraform_remote_state.global.outputs.tls_security_group_id]
}
