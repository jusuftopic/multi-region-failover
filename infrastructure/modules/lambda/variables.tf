variable "failover_table_arn" {
  description = "The ARN of the DynamoDB table to which the failover lambda will write"
  type = string
}

variable "failover_table_name" {
  description = "The name of the DynamoDB table to which the failover lambda will write"
  type = string
}

variable "failover_lambda_zip_bucket_id" {
  description = "The ID of the S3 bucket where the failover lambda zip file is stored"
  type = string
}

variable "runtime" {
  description = "The runtime to use for the failover lambda"
  type = string
  default = "python3.9"
}

variable "handler" {
  description = "The handler to use for the failover lambda"
  type = string
  default = "handler.lambda_handler"
}

variable "timeout" {
  description = "The timeout for the failover lambda"
  type = number
  default = 15
}

variable "memory_size" {
  description = "Memory size for the Lambda function in MB"
  type        = number
  default     = 128
}
