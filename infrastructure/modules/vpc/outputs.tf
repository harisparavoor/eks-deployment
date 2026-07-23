output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "alb_security_group_id" {
  description = "Security group ID for ALB"
  value       = aws_security_group.alb.id
}

output "eks_security_group_id" {
  description = "Security group ID for EKS worker nodes"
  value       = aws_security_group.eks.id
}
output "alb_to_pods_security_group_id" {
  description = "Security group ID for ALB to pods traffic"
  value       = aws_security_group.alb_to_pods.id
}

output "rds_security_group_id" {
  description = "Security group ID for RDS"
  value       = aws_security_group.rds.id
}
