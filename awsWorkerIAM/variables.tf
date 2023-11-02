 variable "region" { 
   default ="us-east-1" 
 } 

variable "vpc_id" {
  type        = string
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
	} 
 }
