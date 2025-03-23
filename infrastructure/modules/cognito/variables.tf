variable "failover_user_pool" {
  description = "The name of the Cognito User Pool to create"
  type        = string
}

variable "failover_user_pool_client" {
  description = "The name of the Cognito User Pool Client to create"
  type        = string
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, prod)"
  type        = string
}