variable "environment" {
description = "Deployment environment"
type = string
}

variable "project_name" {
description = "Name of the project"
type = string
}

variable "db_endpoint" {
description = "Database endpoint"
type = string
}

variable "db_name" {
description = "Database name"
type = string
}

variable "db_username" {
description = "Database username"
type = string
}

variable "db_password" {
description = "Database password"
type = string
sensitive = true
}
variable "ecs_task_role_name" {
  description = "Name of the ECS task role to attach the policy to"
  type        = string
}

variable "ecs_task_role" {
  description = "Reference to the ECS task role resource"
  type        = any
}

variable "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution_role.name"
  type        = string
}