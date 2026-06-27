variable "environment" {
description = "Deployment environment"
type = string
}

variable "project_name" {
description = "Name of the project"
type = string
}

variable "vpc_id" {
description = "VPC ID"
type = string
}

/*variable "alb_target_group_arn" {
description = "ARN of the ALB target group for frontend"
type = string
}
*/
variable "alb_listener_arn" {
description = "ARN of the ALB listener"
type = string
}
/*variable "backend_target_group_arn" {
description = "ARN of the ALB target group for backend"
type = string
}
*/
/*variable "frontend_target_group_arn" {
  description = "ARN of the frontend target group"
  type        = string
}
*/
variable "db_secret_arn" {
description = "ARN of the database secret"
type = string
}

variable "ecr_repository_url" {
description = "URL of the frontend ECR repository"
type = string
}

variable "backend_repository_url" {
description = "URL of the backend ECR repository"
type = string
}

variable "alb_security_group_id" {
description = "Security group ID for ALB"
type = string
}

variable "ecs_security_group_id" {
description = "Security group ID for ECS"
type = string
}

variable "private_subnet_ids" {
description = "List of private subnet IDs"
type = list(string)
}
variable "frontend_blue_target_group_name" {
  description = "Name of the frontend blue target group"
  type        = string
}
variable "frontend_blue_target_group_arn" {
  description = "ARN of blue target group for frontend"
  type        = string
}
variable "frontend_green_target_group_name" {
  description = "Name of the frontend green target group"
  type        = string
}
variable "frontend_green_target_group_arn" {
  description = "ARN of green target group for frontend"
  type        = string
}
variable "backend_green_target_group_arn" {
  description = "Backend green target group ARN"
  type        = string
}

variable "backend_green_target_group_name" {
  description = "Name of the backend green target group"
  type        = string
}
variable "backend_blue_target_group_arn" {
  description = "ARN of the backend blue target group"
  type        = string
}

variable "backend_blue_target_group_name" {
  description = "Name of the backend green target group"
  type        = string
}
