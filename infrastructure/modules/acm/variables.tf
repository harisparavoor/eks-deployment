variable "domain_name" {
description = "Domain name for the certificate"
type = string
}

variable "environment" {
description = "Deployment environment"
type = string
}

variable "route53_zone_id" {
description = "Route53 zone ID for DNS validation"
type = string
}