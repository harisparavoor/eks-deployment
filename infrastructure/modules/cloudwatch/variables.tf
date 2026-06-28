variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "frontend_service_name" {
  description = "Name of the frontend workload"
  type        = string
}

variable "backend_service_name" {
  description = "Name of the backend workload"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  type        = string
  default     = ""
}
