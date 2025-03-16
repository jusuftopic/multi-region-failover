output "failover_lambda_invoke_arn" {
  value = aws_lambda_function.failover_health_check_lambda.invoke_arn
}

