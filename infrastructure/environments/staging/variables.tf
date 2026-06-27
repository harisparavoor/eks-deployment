variable "project_name" {
description = "Name of the project"
type = string
}

variable "aws_region" {
description = "AWS region to deploy resources"
type = string
}

variable "vpc_cidr_block" {
description = "CIDR block for the VPC"
type = string
}

variable "db_name" {
description = "Name of the PostgreSQL database"
type = string
}

variable "db_username" {
description = "Username for the PostgreSQL database"
type = string
}

variable "db_password" {
description = "Password for the PostgreSQL database"
type = string
sensitive = true
}

variable "domain_name" {
description = "Domain name for the application"
type = string
}

variable "route53_zone_id" {
description = "Route53 zone ID"
type = string
}

variable "github_owner" {
description = "GitHub repository owner"
type = string
}

variable "github_repo_frontend" {
description = "GitHub repository name for frontend"
type = string
}

variable "github_repo_backend" {
description = "GitHub repository name for backend"
type = string
}

variable "github_branch" {
description = "GitHub branch to trigger pipeline"
type = string
}

variable "github_token" {
description = "GitHub OAuth token"
type = string
sensitive = true
}

variable "github_webhook_token" {
description = "GitHub webhook secret token"
type = string
sensitive = true
}
