#########################################################
# Variables
#########################################################

# account Number used for the S3 Backup Bucket
variable "region" {
  default ="eu-central-1"
}

variable tags {
  description = "default tags to use"

  default = {
    Name             = "terraform-ec2-simple-userdata"
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
    ami = "ami-018f4111feee6f553"
    instance_type = "t3.nano"
    vpc_security_group_ids = ["sg-0b9691951c02819ba"]
    //subnet_id              => see ec2.tf now it is extracted from datasource "landingzone_state"
    iam_instance_profile   = "ec2"  
    }
}

variable "account_id" {
  default = "004326122988"
}
