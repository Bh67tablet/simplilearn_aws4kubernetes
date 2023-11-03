data "aws_subnet" "get-subnet-id" {
  filter {
    name   = "tag:Name"
    values = ["public1"]
  }

}

output "aws_subnet_id" {
  value = data.aws_subnet.get-subnet-id.id
}
