output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
  description = "The ID of the Cognito User Pool Client"
}

output "user_pool_endpoint" {
  value = aws_cognito_user_pool.user_pool.endpoint
  description = "The endpoint of the Cognito User Pool"
  sensitive = true
}