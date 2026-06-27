variable "environment" {
description = "Deployment environment"
type = string
}

variable "vpc_id" {
description = "VPC ID"
type = string
}

variable "public_subnet_ids" {
description = "List of public subnet IDs"
type = list(string)
}

variable "alb_security_group_id" {
description = "Security group ID for ALB"
type = string
}

variable "domain_name" {
description = "Domain name for the application"
type = string
}

variable "acm_certificate_arn" {
description = "ACM certificate ARN"
type = string
}

/*variable "route53_zone_id" {
description = "Route53 zone ID"
type = string
}
*/
variable "logs_bucket_name" {
  description = "S3 bucket for ALB access logs"
  type        = string
}

variable "alb_logs_policy" {
  description = "Reference to the S3 bucket policy resource"
  type        = any
}