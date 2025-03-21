# The HTTP API is chosen for its low latency, better performance, and cost reduction reasons.
resource "aws_apigatewayv2_api" "failover_api_gateway" {
  name          = var.api_gateway_name
  protocol_type = "HTTP"

  tags = {
    Environment = var.environment
  }
}

resource "aws_apigatewayv2_stage" "failover_api_gateway_stage" {
  api_id = aws_apigatewayv2_api.failover_api_gateway.id
  name   = var.api_gateway_stage_name
  auto_deploy = true

    tags = {
        Environment = var.environment
    }
}

# Integration resource for the failover API Gateway
resource "aws_apigatewayv2_integration" "failover_api_gateway_integration" {
  api_id           = aws_apigatewayv2_api.failover_api_gateway.id
  integration_type = "AWS_PROXY"
  integration_method = "POST"
  integration_uri = var.lambda_invoke_arn
}

# Authorize resource for the failover API Gateway
resource "aws_apigatewayv2_authorizer" "cognito_authorizer" {
  api_id          = aws_apigatewayv2_api.failover_api_gateway.id
  authorizer_type = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name            = var.cognito_authorizer_name
  jwt_configuration {
    audience = [var.user_pool_client_id]
    issuer   = var.user_pool_endpoint
  }
}

# Route resource for the failover API Gateway
resource "aws_apigatewayv2_route" "failover_api_gateway_route" {
  api_id = aws_apigatewayv2_api.failover_api_gateway.id

  route_key = "GET /health-check"
  target    = "integrations/${aws_apigatewayv2_integration.failover_api_gateway_integration.id}"
  authorizer_id = aws_apigatewayv2_authorizer.cognito_authorizer.id
}

# Permission to allow API Gateway to invoke the Lambda function
resource "aws_lambda_permission" "failover_api_gateway_lambda_permission" {
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.failover_api_gateway.execution_arn}/*/*/*"
}