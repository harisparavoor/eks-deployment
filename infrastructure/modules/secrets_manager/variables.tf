variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "db_endpoint" {
  description = "Database endpoint"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
variable "workload_role_name" {
  description = "Name of the workload role to attach the policy to"
  type        = string
  default     = ""
}

variable "workload_role" {
  description = "Reference to the workload role resource"
  type        = any
  default     = null
}

variable "workload_execution_role_name" {
  description = "Name of the execution role name"
  type        = string
  default     = ""
}
