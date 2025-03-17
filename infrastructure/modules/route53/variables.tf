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