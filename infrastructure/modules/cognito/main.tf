# Create a Cognito User Pool
resource "aws_cognito_user_pool" "user_pool" {
  name = var.failover-user-pool

  # Configure the user pool attributes
  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = false
  }

  auto_verified_attributes = ["email"]

  tags = {
    Environment = var.environment
  }
}

# Create a Cognito User Pool Client
resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = var.failover-user-pool-client
  user_pool_id = aws_cognito_user_pool.user_pool.id

  # Allow the client to authenticate users
  allowed_oauth_flows       = ["code"]
  allowed_oauth_scopes      = ["email", "openid", "profile"]
  allowed_oauth_flows_user_pool_client = true

  # Enable the client to generate a secret
  generate_secret = true

}