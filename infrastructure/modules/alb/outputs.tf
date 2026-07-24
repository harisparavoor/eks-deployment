##########################################
# ALB Outputs
##########################################

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.main.arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = aws_lb.main.zone_id
}

output "backend_target_group_arn" {
  description = "ARN of the backend Target Group"
  value       = aws_lb_target_group.backend.arn
}

output "frontend_target_group_arn" {
  description = "ARN of the Frontend Target Group"
  value       = aws_lb_target_group.frontend.arn
}

output "frontend_target_group_name" {
  description = "Name of the Frontend Target Group"
  value       = aws_lb_target_group.frontend.name
}

output "alb_controller_role_arn" {
  description = "ARN of the ALB Controller IAM role"
  value       = aws_iam_role.alb_controller.arn
}
