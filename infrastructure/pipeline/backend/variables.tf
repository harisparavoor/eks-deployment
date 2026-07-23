variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "artifacts_bucket_arn" {
  description = "S3 bucket for artifacts"
  type        = string
}

variable "artifacts_bucket_name" {
  description = "S3 bucket for artifacts"
  type        = string
}


variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "github_repo_backend" {
  description = "GitHub repository name for backend"
  type        = string
}

variable "backend_appname" {
  description = "Name of the backend application"
  type        = string
}

variable "frontend_appname" {
  description = "Name of the frontend application"
  type        = string
}
variable "github_branch" {
  description = "GitHub branch to trigger pipeline"
  type        = string
}

variable "github_token" {
  description = "GitHub OAuth token"
  type        = string
  sensitive   = true
}

variable "github_webhook_token" {
  description = "GitHub webhook secret token"
  type        = string
  sensitive   = true
}

variable "ecr_repository_url" {
  description = "ECR repository URL for backend"
  type        = string
}

variable "codestar_connection_arn" {
  description = "The ARN of the CodeStar connection"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster targeted by CodeBuild deployments"
  type        = string
}

variable "backend_target_group_arn" {
  description = "The ARN of the backend Target Group"
  type        = string
}
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
}
variable "aws_region" {
  description = "The AWS region"
  type        = string
}
variable "alb_controller_role_arn" {
  description = "The ARN of the ALB controller role"
  type        = string
}
/*
variable "backend_blue_target_group_name" {
  description = "Name of blue target group for backend"
  type        = string
}

variable "backend_green_target_group_name" {
  description = "NAME of green target group for backend"
  type        = string
}
variable "alb_listener_arn" {
  description = "ARN of the ALB listener"
  type        = string
}
*/
