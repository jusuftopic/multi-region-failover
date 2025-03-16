# Define an IAM role for the Lambda function
resource "aws_iam_role" "failover_lambda_role" {
  name = "failover_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Define an IAM policy for the Lambda function
resource "aws_iam_policy" "failover_lambda_policy" {
  name = "failover_lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem"
        ],
        Resource = var.failover_table_arn
      }
    ]
  })
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "failover_lambda_policy_attachment" {
  role = aws_iam_role.failover_lambda_role.name
  policy_arn = aws_iam_policy.failover_lambda_policy.arn
}

# Create a ZIP archive of the Lambda function code
resource "archive_file" "failover_lambda_zip" {
  source_dir = "${path.module}/../../../lambda/failover-lambda"
  output_path = "${path.module}/../../../lambda/failover-lambda.zip"
  type        = "zip"
}

# Upload the ZIP archive to an S3 bucket
resource "aws_s3_object" "lambda_zip" {
  bucket = var.failover_lambda_zip_bucket_id
  key    = "lambda.zip"
  source = archive_file.failover_lambda_zip.output_path

  # The etag is a hash of the object's data. If the data changes, the etag changes.
  etag = filemd5(archive_file.failover_lambda_zip.output_path)
}

# Define the Lambda function
resource "aws_lambda_function" "failover_health_check_lambda" {
  function_name = "failover_health_check"

  s3_bucket = var.failover_lambda_zip_bucket_id
  s3_key = aws_s3_object.lambda_zip.key

  role = aws_iam_role.failover_lambda_role.arn

  runtime = var.runtime
  handler = var.handler

  timeout = var.timeout
  memory_size = var.memory_size

  source_code_hash = archive_file.failover_lambda_zip.output_base64sha256

  # Set environment variables for the Lambda function
  environment {
    variables = {
      FAILOVER_TABLE_NAME = var.failover_table_name
    }
  }
}