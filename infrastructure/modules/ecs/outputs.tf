output "ecs_cluster_name" {
description = "Name of the ECS cluster"
value = aws_ecs_cluster.main.name
}

output "frontend_service_name" {
description = "Name of the frontend ECS service"
value = aws_ecs_service.frontend.name
}

output "backend_service_name" {
description = "Name of the backend ECS service"
value = aws_ecs_service.backend.name
}

output "frontend_task_definition_arn" {
description = "ARN of the frontend task definition"
value = aws_ecs_task_definition.frontend.arn
}

output "backend_task_definition_arn" {
description = "ARN of the backend task definition"
value = aws_ecs_task_definition.backend.arn
}

output "codedeploy_app_name_frontend" {
description = "Name of the frontend CodeDeploy application"
value = aws_codedeploy_app.frontend.name
}

output "codedeploy_app_name_backend" {
description = "Name of the backend CodeDeploy application"
value = aws_codedeploy_app.backend.name
}

output "codedeploy_deployment_group_frontend" {
description = "Name of the frontend CodeDeploy deployment group"
value = aws_codedeploy_deployment_group.frontend.deployment_group_name
}

output "codedeploy_deployment_group_backend" {
description = "Name of the backend CodeDeploy deployment group"
value = aws_codedeploy_deployment_group.backend.deployment_group_name
}
output "ecs_task_role_name" {
  description = "Name of the ECS task role"
  value       = aws_iam_role.ecs_task_role.name
}

output "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution_role.name"
  value       = aws_iam_role.ecs_task_execution_role.name
}

output "ecs_task_role" {
  description = "Name of the ECS task role"
  value       = aws_iam_role.ecs_task_role
}