output "frontend_url" {
description = "URL of the frontend application"
value = "https://${var.domain_name}"
}

output "backend_url" {
description = "URL of the backend API"
value = "https://${var.domain_name}/api"
}

output "frontend_pipeline_name" {
description = "Name of the frontend pipeline"
value = module.frontend_pipeline.pipeline_name
}

output "backend_pipeline_name" {
description = "Name of the backend pipeline"
value = module.backend_pipeline.pipeline_name
}

output "ecr_frontend_repository_url" {
description = "URL of the frontend ECR repository"
value = module.ecr.frontend_repository_url
}

output "ecr_backend_repository_url" {
description = "URL of the backend ECR repository"
value = module.ecr.backend_repository_url
}

output "rds_endpoint" {
description = "Endpoint of the RDS instance"
value = module.rds.db_endpoint
}

output "alb_dns_name" {
description = "DNS name of the ALB"
value = module.alb.alb_dns_name
}
