variable "project_name" {
description = "Name of the project"
type = string
}
variable "domain_name" {
description = "Domain name for the application"
type = string
}
variable "environment" {
description = "Deployment environment"
type = string
}

variable "artifacts_bucket_arn" {
description = "S3 bucket for artifacts"
type = string
}

variable "artifacts_bucket_name" {
description = "S3 bucket for artifacts"
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

variable "ecr_repository_url" {
description = "ECR repository URL for frontend"
type = string
}

variable "codedeploy_app_name" {
description = "CodeDeploy application name"
type = string
}

variable "codedeploy_deployment_group" {
description = "CodeDeploy deployment group name"
type = string
}
variable "codestar_connection_arn" {
  description = "The ARN of the CodeStar connection"
  type        = string
}

variable "frontend_blue_target_group_name" {
  description = "Name of blue target group for frontend"
  type        = string
}

variable "frontend_green_target_group_name" {
  description = "NAME of green target group for frontend"
  type        = string
}
variable "alb_listener_arn" {
description = "ARN of the ALB listener"
type = string
}
variable "frontend_task_definition_arn" {
description = "ARN of the frontend task definition"
type = string
}

variable "alb_dns_name" {
description = "DNS name of the ALB"
type=string
}