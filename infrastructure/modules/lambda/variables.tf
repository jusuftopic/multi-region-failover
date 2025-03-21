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
}

variable "handler" {
  description = "The handler to use for the failover lambda"
  type = string
}

variable "timeout" {
  description = "The timeout for the failover lambda"
  type = number
  validation {
    condition = var.timeout >= 1 && var.timeout <= 900
    error_message = "The timeout must be between 1 and 900 seconds"
  }
}

variable "memory_size" {
  description = "Memory size for the Lambda function in MB"
  type        = number
  validation {
    condition = var.memory_size >= 128 && var.memory_size <= 1024
    error_message = "Memory size must be between 128 and 1024 MB"
  }
}
