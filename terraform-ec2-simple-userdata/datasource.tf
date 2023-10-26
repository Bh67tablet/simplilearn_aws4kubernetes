// Reference to Core Module State
data "terraform_remote_state" "landingzone_statefile" {
  backend = "s3"
  config = {
    bucket  = "${var.account_id}-terraformstates"# each account has its own terraform states bucket. consists of <account-nr>- terraformstates
    key     = "core-init/state"                  # core-init is a reference of the core module state within the account 
    region  = "eu-central-1"                     # we always stay in Frankfurt
    }
  
}