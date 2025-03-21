# DynamoDB table holding data health data about primary and standby region
# Stores the health status of the primary and standby regions
# but accept flexible schema to store other region-related data
resource "aws_dynamodb_table" "failover_table" {
  name = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "PK"
  range_key = "SK"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

  attribute {
    name = "last_checked"
    type = "S"
  }

  tags = {
    Name = var.table_name
    Environment = var.environment
  }
}
