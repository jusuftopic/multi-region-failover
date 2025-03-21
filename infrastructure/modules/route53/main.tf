# Public hosted zone for custom domain
resource "aws_route53_zone" "failover_hosted_zone" {
  name = var.domain_name

  tags = {
    Environment = var.environment
    Name        = var.domain_name
  }
}

resource "aws_route53_record" "failover_record" {
  for_each = var.regions

  zone_id = aws_route53_zone.failover_hosted_zone.zone_id
  name    = "api.${var.domain_name}"
  type    = "A"

  alias {
    name                   = each.value.gateway_domain_name
    zone_id                = each.value.gateway_zone_id
    evaluate_target_health = true
  }

  set_identifier = each.key
  failover_routing_policy {
    type = each.value.health_type
  }

  health_check_id = aws_route53_health_check.health[each.key].id
}


resource "aws_route53_health_check" "health" {
  for_each = var.regions

  type              = "HTTPS"
  resource_path     = "/health-check"
  fqdn              = each.value.gateway_domain_name
  port              = 443
  failure_threshold = 3
  request_interval  = 30
}
