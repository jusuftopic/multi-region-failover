variable "domain_name" {
    description = "The domain name for the hosted zone"
    type        = string
}

variable "primary_gateway_domain_name" {
    description = "The domain name of the primary API gateway"
    type        = string
}

variable "primary_gateway_zone_id" {
    description = "The zone ID of the primary API gateway"
    type        = string
}

variable "standby_gateway_domain_name" {
    description = "The domain name of the standby API gateway"
    type        = string
}

variable "standby_gateway_zone_id" {
    description = "The zone ID of the standby API gateway"
    type        = string
}

variable "environment" {
    description = "The environment for the resources (e.g., dev, prod)"
    type        = string
}

variable "regions" {
    description = "Mapping of primary and standby API gateway details"
    type = map(object({
        gateway_domain_name = string
        gateway_zone_id     = string
        health_type         = string
    }))
}