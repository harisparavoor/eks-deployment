output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "Endpoint for the EKS cluster"
  value       = aws_eks_cluster.main.endpoint
}

output "node_group_name" {
  description = "Name of the EKS node group"
  value       = aws_eks_node_group.main.node_group_name
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL"
  value       = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}


output "oidc_provider_arn" {
  description = "ARN of the OIDC provider"
  value       = aws_iam_openid_connect_provider.eks.arn
}
output "eks_cluster_security_group_id" {
  description = "Security group ID for EKS cluster"
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}
