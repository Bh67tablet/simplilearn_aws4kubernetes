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
		vpc_id = "vpc-0d579d6573dfe4b2d"
		subnet_id ="subnet-08e859590b953e09c"
	} 
 }
