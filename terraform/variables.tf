 variable "region" { 
   default ="us-east-1" 
 } 
  
 variable tags { 
   description = "default tags to use" 
  
   default = { 
     Name             = "AnsibleMaster" 
     Confidelity      = "C2" 
     Environment      = "Sandbox" 
     ManagedBy        = "firstname.lastname@vodafone.com" 
     NetworkType      = "I-A" 
     Project          = "Sandbox" 
     TaggingVersion   = "V2.4" 
   } 
 } 
  
 variable "ec2_parameters" { 
   default = { 
		region = "us-east-1"
		vpc = "vpc-0ea4c6b825b733b09"
		ami = "ami-0fc5d935ebf8bc3bc"
		itype = "t2.micro"
		subnet = "subnet-0c4d6ac22631a5e56"
		publicip = true
		keyname = "simplilearn_key"
		secgroupname = "bh67sg"  
	} 
 }
