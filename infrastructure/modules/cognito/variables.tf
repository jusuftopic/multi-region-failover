variable "failover-user-pool" {
  description = "The name of the Cognito User Pool to create"
  type        = string
}

variable "failover-user-pool-client" {
  description = "The name of the Cognito User Pool Client to create"
  type        = string
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, prod)"
  type        = string
}