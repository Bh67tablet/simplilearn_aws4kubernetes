 variable "region" { 
   default ="us-east-1" 
 } 
  
 variable "ec2_parameters" { 
   default = { 
		region = "us-east-1"
		vpc = "vpc-02072287009b3f29c"
		ami = "ami-0fc5d935ebf8bc3bc"
		itype = "t2.micro"
		subnet = "subnet-010708c3ba9901af5"
		publicip = true
		keyname = "simplilearn_key"
		secgroupname = "bh67sg" 
		iam_instance_profile   = "test_profile"
	} 
 }
