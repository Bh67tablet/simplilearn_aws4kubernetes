data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

output "first_subnet_id" {
        value = sort(data.aws_subnets.all.ids)[0]
}

output "vpc_id" {
  description = "ID of project VPC"
  value       = [data.aws_vpc.default.id]
}

output "aws_security_group_name" {
  value = aws_security_group.bh67sg[*].id
}
