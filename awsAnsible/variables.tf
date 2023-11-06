variable "region" { 
default ="us-east-1" 
} 

variable "subnet_id" {
  type        = string
}

variable "security_group_ids" {
  description = "List of ingress rules to create where 'source_security_group_id' is used"
  type        = list(string)
  default     = []
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
