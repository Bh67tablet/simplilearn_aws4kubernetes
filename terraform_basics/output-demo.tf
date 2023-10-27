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
