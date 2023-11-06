data "aws_vpc" "default" {
  default = true
}

output "vpc_id" {
  description = "ID of project VPC"
  value       = [data.aws_vpc.default.id]
}
