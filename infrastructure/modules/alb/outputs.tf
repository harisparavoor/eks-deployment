output "alb_dns_name" {
description = "DNS name of the ALB"
value = aws_lb.main.dns_name
}

/*output "alb_target_group_arn" {
description = "ARN of the ALB target group"
value = aws_lb_target_group.frontend.arn
}
*/
/*output "alb_listener_arn" {
description = "ARN of the ALB listener"
value = aws_lb_listener.frontend_https.arn
}
*/
output "alb_arn" {
  value = aws_lb.main.arn
}

output "frontend_https_listener_arn" {
  value = aws_lb_listener.frontend_https.arn
}

/*output "frontend_target_group_arn" {
description = "ARN of the frontend target group"
value = aws_lb_target_group.frontend.arn
}
*/
output "frontend_blue_target_group_name" {
description = "Name of the frontend blue target group"
value = aws_lb_target_group.frontend_blue.name
}

output "frontend_blue_target_group_arn" {
description = "ARN of the frontend blue target group"
value = aws_lb_target_group.frontend_blue.arn
}
output "frontend_green_target_group_name" {
description = "name of the frontend green target group"
value = aws_lb_target_group.frontend_green.name
}

output "frontend_green_target_group_arn" {
description = "ARN of the frontend green target group"
value = aws_lb_target_group.frontend_green.arn
}

output "backend_blue_target_group_arn" {
description = "ARN of the backend blue target group"
value = aws_lb_target_group.backend_blue.arn
}

output "backend_blue_target_group_name" {
  description = "Name of the backend blue target group"
  value       = aws_lb_target_group.backend_blue.name
}

output "backend_green_target_group_name" {
  description = "Name of the backend green target group"
  value       = aws_lb_target_group.backend_green.name
}
output "backend_green_target_group_arn" {
description = "ARN of the backend green target group"
value = aws_lb_target_group.backend_green.arn
}

