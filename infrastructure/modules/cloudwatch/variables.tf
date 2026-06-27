variable "environment" {
description = "Deployment environment"
type = string
}

variable "ecs_cluster_name" {
description = "Name of the ECS cluster"
type = string
}

variable "frontend_service_name" {
description = "Name of the frontend ECS service"
type = string
}

variable "backend_service_name" {
description = "Name of the backend ECS service"
type = string
}

variable "sns_topic_arn" {
description = "ARN of the SNS topic for alerts"
type = string
default = ""
}
