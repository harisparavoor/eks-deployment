variable "environment" {
description = "Deployment environment"
type = string
}

variable "frontend_repository_name" {
description = "Name of the frontend ECR repository"
type = string
}

variable "backend_repository_name" {
description = "Name of the backend ECR repository"
type = string
}
