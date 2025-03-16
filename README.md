# Multi-Region Failover Strategy on AWS

## 📌 Project Overview

Ensuring high availability and fault tolerance is critical for modern cloud applications. This project implements a multi-region failover strategy using AWS services to maintain application resilience even in the case of a regional outage. By leveraging AWS API Gateway, Lambda, DynamoDB, Route 53, and Terraform, I demonstrate how to build an infrastructure that can automatically detect failures and shift traffic to a healthy region.

✅ **Scalability** - Distributing workloads across regions reduces latency for global users.

✅ **Business Continuity** - Maintains seamless user experience and trust.

## 📐 Architectural Decisions

1️⃣ **Multi-Region Deployment**

- The application is deployed in two AWS regions (Primary & Secondary).
- AWS Route 53 handles DNS-based failover to reroute traffic when the primary region is unhealthy.
- AWS DynamoDB Global Tables store regional health status.

2️⃣ **Automated Health Checks & Failover**

- AWS Lambda updates health status for each region in DynamoDB.
- API Gateway exposes a `/health-check` endpoint, allowing an external monitor (e.g., Route 53 Health Checks) to verify the region's status.
- If the primary region fails, Route 53 redirects traffic to the secondary region.

3️⃣ **Infrastructure as Code (IaC) with Terraform**

- The entire architecture (API Gateway, Lambda, DynamoDB, Route 53) is provisioned using Terraform.
- Modular Terraform structure ensures easy deployment and scalability.

## 🚀 AWS Services Used

☁️ **API Gateway (HTTP API)**

- Provides a lightweight, cost-effective API endpoint for health checks.
- Uses a Cognito JWT Authorizer for secure access.

🛠️ **AWS Lambda (Python)**

- Periodically updates DynamoDB with health status.
- Deployed in both regions to maintain real-time availability.

📊 **DynamoDB (Global Table)**

- Stores the health status of each AWS region.
- Enables global replication for fast failover detection.

🌍 **Route 53**

- Routes traffic between primary and secondary regions.
- Uses health checks to determine failover conditions.

🛠️ **Terraform**

- Infrastructure is defined as code for repeatable, consistent deployment.
- Uses modules for API Gateway, Lambda, DynamoDB, and Route 53.

## 📌 Conclusion

This project demonstrates the power of multi-region failover for a resilient AWS cloud architecture. By leveraging AWS's global infrastructure, we ensure high availability, disaster recovery, and a seamless user experience in the face of regional failures.