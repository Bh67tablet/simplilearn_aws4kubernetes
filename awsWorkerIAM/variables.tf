 variable "region" { 
   default ="us-east-1" 
 } 

 variable "ec2_parameters" { 
   default = { 
		region = "us-east-1"
		ami = "ami-0fc5d935ebf8bc3bc"
		itype = "t2.micro"
		publicip = true
		keyname = "simplilearn_key"
		secgroupname = "bh67sg"
		vpc_id = "vpc-006d5e56c7982620c"
		subnet_id ="subnet-0c11c8af59aaa8e88"
	} 
 }
