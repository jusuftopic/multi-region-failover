variable "primary_region_name" {
    description = "The name of the primary region"
    type        = string
}

variable "standby_region_name" {
  description = "The name of the standby region"
  type        = string
}

variable "primary_dynamodb_table" {
  description = "The name of the primary DynamoDB table"
  type        = string
}

variable "standby_dynamodb_table" {
  description = "The name of the standby DynamoDB table"
  type        = string
}

variable "failover_dynamodb_global_table_name" {
  description = "The name of the global DynamoDB table"
  type        = string
}

variable "provider" {
  description = "The provider to use for the global DynamoDB table"
  type        = string
}
