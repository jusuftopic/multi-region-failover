import boto3
from datetime import datetime
import os

# Get region dynamically from AWS Lambda environment
REGION = os.getenv("AWS_REGION", "us-east-1")
DYNAMODB_TABLE_NAME = os.getenv("FAILOVER_TABLE_NAME")

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(DYNAMODB_TABLE_NAME)

def lambda_handler(event, context):
    """
   This function updates the health status of the current AWS region in DynamoDB.
   """
    now = datetime.now().isoformat()

    health_status = perform_health_check()

    item = {
        "PK": f"region#{REGION}",
        "SK": "health-check",
        "status": health_status,
        "last_checked": now
    }

    table.put_item(Item=item)

    return {
        "statusCode": 200,
        "headers": {
            'Access-Control-Allow-Origin': get_origin(event),
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Methods': 'GET'
        },
        "body": f"Updated health status for {REGION} as {health_status}"
    }


def get_origin(event):
    """
    Get the origin from the request headers.
    """
    return event.get("headers", {}).get("origin", "*")


def perform_health_check():
    """
    Simulate a health check.
    This should be replaced with actual health check logic (e.g., API calls, DB queries, etc.).
    """
    return "healthy"