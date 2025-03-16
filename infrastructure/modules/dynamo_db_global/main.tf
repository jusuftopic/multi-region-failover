# Resource for creating a global DynamoDB table with failover capabilities
resource "aws_dynamodb_global_table" "failover_table_global" {
  depends_on = [
    var.primary_dynamodb_table,
    var.standby_dynamodb_table
  ]

  provider = var.provider

  name = var.failover_dynamodb_global_table_name

  replica {
    region_name = var.primary_region_name
  }

  replica {
    region_name = var.standby_region_name
  }
}