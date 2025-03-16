variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "failover_lambda_invoke_arn" {
  description = "The ARN of the Lambda function to be invoked by the API Gateway"
  type        = string
}

variable "failover_lambda_function_name" {
    description = "The name of the Lambda function to be invoked by the API Gateway"
    type        = string
}

variable "api_gateway_stage_name" {
  description = "The name of the API Gateway stage"
  type        = string
}

variable "user_pool_client_id" {
  description = "The ID of the Cognito User Pool Client"
}

variable "user_pool_endpoint" {
  description = "The endpoint of the Cognito User Pool"
  type = string
}