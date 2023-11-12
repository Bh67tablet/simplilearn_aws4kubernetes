resource "aws_instance" "ec2master" {
	count = 2
	ami                    = "ami-0fc5d935ebf8bc3bc"
	instance_type          = "t2.micro"
	key_name               = "simplilearn_key"
	subnet_id = data.terraform_remote_state.global.outputs.lambda_subnet_id
	vpc_security_group_ids = [data.terraform_remote_state.global.outputs.tls_security_group_id]
}
