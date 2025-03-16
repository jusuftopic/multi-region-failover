terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_s3_bucket" "failover_terraform_state_bucket" {
  bucket = var.failover_terraform_state_bucket
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "failover_terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.failover_terraform_state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "failover_terraform_state_bucket_encryption" {
  bucket = aws_s3_bucket.failover_terraform_state_bucket.id

  rule {
  apply_server_side_encryption_by_default {
    sse_algorithm     = "AES256"
  }
  }
}

resource "aws_dynamodb_table" "failover_terraform_state_locks" {
  name = var.failover_terraform_state_locks
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}