variable "region" { 
default ="us-east-1" 
} 

variable "subnet_id" {
  type        = string
}

variable "ec2_parameters" { 
	default = { 
		region = "us-east-1"
		ami = "ami-0fc5d935ebf8bc3bc"
		itype = "t2.micro"
		publicip = true
		keyname = "simplilearn_key"
		secgroupname = "bh67sg" 
		iam_instance_profile   = "test_profile"
	} 
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}
