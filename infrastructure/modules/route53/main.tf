terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}
# Public hosted zone for custom domain
resource "aws_route53_zone" "failover_hosted_zone" {
  name = var.domain_name
}

# Hosted zone record for the primary region
resource "aws_route53_record" "primary_region_record" {
  zone_id = aws_route53_zone.failover_hosted_zone.zone_id
  name    = "api.${var.domain_name}"
  type    = "A"

  alias {
    name = var.primary_gateway_domain_name
    zone_id = var.primary_gateway_zone_id
    evaluate_target_health = true
  }

  set_identifier = "Primary API"
  failover_routing_policy {
    type = "PRIMARY"
  }

  health_check_id = aws_route53_health_check.primary_health.id
}

# Hosted zone record for the standby region
resource "aws_route53_record" "secondary_region_record" {
  zone_id = aws_route53_zone.failover_hosted_zone.zone_id
  name    = "api.${var.domain_name}"
  type    = "A"

  alias {
    name = var.standby_gateway_domain_name
    zone_id = var.standby_gateway_zone_id
    evaluate_target_health = true
  }

  set_identifier = "Standby API"
  failover_routing_policy {
    type = "SECONDARY"
  }

  health_check_id = aws_route53_health_check.standby_health.id
}

resource "aws_route53_health_check" "primary_health" {
  type = "HTTPS"
  resource_path = "/health-check"
  fqdn = "api.${var.domain_name}"
  port = 443
  failure_threshold = 3
  request_interval = 30
}

resource "aws_route53_health_check" "standby_health" {
  type = "HTTPS"
  resource_path = "/health-check"
  fqdn = "api.${var.domain_name}"
  port = 443
  failure_threshold = 3
  request_interval = 30
}