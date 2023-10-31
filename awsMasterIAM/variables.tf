 variable "region" { 
   default ="us-east-1" 
 } 
  
 variable "ec2_parameters" { 
   default = { 
		region = "us-east-1"
		vpc = "vpc-0e830c64ce04494b0"
		ami = "ami-0fc5d935ebf8bc3bc"
		itype = "t2.micro"
		subnet = "subnet-0ee287dfb7f3142f7"
		publicip = true
		keyname = "simplilearn_key"
		secgroupname = "bh67sg" 
		iam_instance_profile   = "test_profile"
		vpc_security_group_ids = ["sg-0164dd95dd71ac5c4"]
	} 
 }
