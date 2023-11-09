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
		vpc_id = "vpc-04688f7bd42cd9f1f"
		subnet_id ="subnet-00eeb860859108603"
	} 
 }
