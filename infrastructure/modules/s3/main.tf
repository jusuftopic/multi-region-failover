# Create resource for s3 bucket to store the lambda zip file
resource "aws_s3_bucket" "lambda_zip_bucket" {
  bucket = var.lambda_bucket_name

    tags = {
      Name = var.lambda_bucket_name
    }
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "lambda_zip_bucket_versioning" {
  bucket = aws_s3_bucket.lambda_zip_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "lambda_zip_bucket_encryption" {
  bucket = aws_s3_bucket.lambda_zip_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

# Block all public access to the bucket (bucket level restriction)
resource "aws_s3_bucket_public_access_block" "lambda_zip_bucket_public_access_block" {
  bucket = aws_s3_bucket.lambda_zip_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

# Deny all public access through a bucket policy
resource "aws_s3_bucket_policy" "lambda_zip_bucket_security_policy" {
  bucket = aws_s3_bucket.lambda_zip_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Deny",
        Principal = "*",
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.lambda_zip_bucket.id}",
          "arn:aws:s3:::${aws_s3_bucket.lambda_zip_bucket.id}/*"
        ],

        Condition = {
          Bool = {
            "aws:SecureTransport": "false"
          }
        }
      }
    ]
  })
}


# Lifecycle rule to delete old versions of the Lambda ZIP files
resource "aws_s3_bucket_lifecycle_configuration" "lambda_zip_bucket_lifecycle" {
  bucket = aws_s3_bucket.lambda_zip_bucket.id

  rule {
    id     = "lambda_zip_cleanup"
    status = "Enabled"

    filter {
      prefix = "lambda-zips/"
    }

    expiration {
      days = 30 # Delete old versions after 30 days
    }

    noncurrent_version_expiration {
      days = 7 # Delete old versions after 7 days
    }
  }
}