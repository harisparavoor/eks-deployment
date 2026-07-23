variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}
variable "eks_cluster_sg_id" {
  description = "Security group ID for EKS cluster"
  type        = string
}
