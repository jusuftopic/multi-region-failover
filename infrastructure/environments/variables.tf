variable "failover_terraform_state_bucket" {
  description = "The name of the S3 bucket to store the Terraform state file"
  type        = string
  default = "default_bucket"
}

variable "failover_terraform_state_locks" {
  description = "The name of the DynamoDB table to store the Terraform state locks"
  type        = string
  default = "default_table"
}