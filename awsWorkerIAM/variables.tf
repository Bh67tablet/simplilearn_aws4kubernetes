 variable "region" { 
   default ="us-east-1" 
 } 
  
 variable "ec2_parameters" { 
   default = { 
		region = "us-east-1"
		vpc = "vpc-0b7844fe1d4df504f"
		ami = "ami-0fc5d935ebf8bc3bc"
		itype = "t2.micro"
		subnet = "subnet-0040d5134f06f1d98"
		publicip = true
		keyname = "simplilearn_key"
		secgroupname = "bh67sg"  
	} 
 }
