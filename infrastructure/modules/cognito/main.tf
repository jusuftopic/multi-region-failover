# Create a Cognito User Pool
resource "aws_cognito_user_pool" "user_pool" {
  name = var.failover_user_pool

  # Configure the user pool attributes
  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = false
  }

  auto_verified_attributes = ["email"]

  # Configure the password policy to enforce better security
  password_policy {
    minimum_length    = 12
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
    temporary_password_validity_days = 7
  }

  tags = {
    Environment = var.environment
  }
}

# Create a Cognito User Pool Client
resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = var.failover_user_pool_client
  user_pool_id = aws_cognito_user_pool.user_pool.id

  # Allow the client to authenticate users
  allowed_oauth_flows       = ["code"]
  allowed_oauth_scopes      = ["email", "openid", "profile"]
  allowed_oauth_flows_user_pool_client = true

  # disabled for security reasons for public-facing apps
  generate_secret = false

}