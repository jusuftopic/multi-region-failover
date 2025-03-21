variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, prod)"
  type        = string
}