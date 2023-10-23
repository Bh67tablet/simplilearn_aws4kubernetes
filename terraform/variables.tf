 variable "region" { 
   default ="us-east-1" 
 } 
  
 variable "ec2_parameters" { 
   default = { 
		region = "us-east-1"
		vpc = "vpc-0566166c204b7eca4"
		ami = "ami-0fc5d935ebf8bc3bc"
		itype = "t2.micro"
		subnet = "subnet-06e127888fec6f91a"
		publicip = true
		keyname = "simplilearn_key"
		secgroupname = "bh67sg"  
	} 
 }
