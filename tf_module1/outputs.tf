output "vpc_id" {
  value   	= aws_vpc.main.id
  description = "ID of the main VPC"
}
 
output "lambda_subnet_id" {
  value   	= aws_subnet.lambda.id
  description = "ID of the subnet dedicated to Lambdas"
}
 
output "tls_security_group_id" {
  value   	= aws_security_group.allow_tls.id
  description = "ID of the allow_tls security group"
}
 
output "lambda_iam_role" {
  value   	= aws_iam_role.iam_for_lambda.arn
  description = "ARN of Lambda execution role"
}
