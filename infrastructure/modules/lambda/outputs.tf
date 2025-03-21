output "failover_lambda_invoke_arn" {
  description = "The ARN to use to invoke the failover lambda"
  value = aws_lambda_function.failover_health_check_lambda.invoke_arn
}

