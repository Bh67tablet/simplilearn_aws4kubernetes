 variable "region" { 
   default ="us-east-1" 
 } 

variable "vpc_id" {
  type        = string
}
  
 variable "ec2_parameters" { 
   default = { 
		region = "us-east-1"
		vpc = var.vpc_id
		ami = "ami-0fc5d935ebf8bc3bc"
		itype = "t2.micro"
		subnet = "subnet-0783c8ac905ea38ba"
		publicip = true
		keyname = "simplilearn_key"
		secgroupname = "bh67sg"  
	} 
 }
