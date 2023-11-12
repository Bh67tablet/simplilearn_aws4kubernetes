output "vpc_id" {
  value   	= aws_vpc.main.id
  description = "ID of the main VPC"
}
 
output "subnet_id" {
  value   	= aws_subnet.lambda.id
  description = "ID of the subnet dedicated to Lambdas"
}
 
output "security_group_id" {
  value   	= aws_security_group.sg.id
}
