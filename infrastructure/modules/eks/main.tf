# eks.tf
resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-${var.environment}-eks"
  role_arn = aws_iam_role.cluster.arn
  #version  = var.eks_version

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    security_group_ids      = [var.eks_security_group_id]
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-eks"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-${var.environment}-ng"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.private_subnet_ids



  #ami_type      = var.node_ami_type != "" ? var.node_ami_type : "AL2_x86_64"
  #capacity_type = "ON_DEMAND"
  #disk_size     = var.node_disk_size != 0 ? var.node_disk_size : 20

  scaling_config {
    desired_size = var.environment == "prod" ? 3 : 1
    max_size     = var.environment == "prod" ? 5 : 2
    min_size     = 1

  }
  instance_types = [var.node_instance_type]

  update_config {
    max_unavailable = 1
  }


  labels = {
    Environment = var.environment
    Project     = var.project_name
    NodeGroup   = "main"
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-ng"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_group_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_group_AmazonEC2ContainerRegistryReadOnly,
  ]
}


resource "aws_iam_role" "cluster" {
  name = "${var.project_name}-${var.environment}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = "${var.project_name}-${var.environment}-eks-cluster-role"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role" "node_group" {
  name = "${var.project_name}-${var.environment}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = "${var.project_name}-${var.environment}-eks-node-role"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_iam_role_policy_attachment" "node_group_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "node_group_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "node_group_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}


data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.main.name
}

data "aws_eks_cluster_auth" "eks" {
  name = data.aws_eks_cluster.eks.name
}

##########################################
# TLS Certificate (OIDC)
##########################################

data "tls_certificate" "eks" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

##########################################
# OIDC Provider (IRSA)
##########################################

resource "aws_iam_openid_connect_provider" "eks" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [
    data.tls_certificate.eks.certificates[0].sha1_fingerprint
  ]

  tags = {
    Name        = "${var.project_name}-${var.environment}-oidc"
    Environment = var.environment
    Project     = var.project_name
  }
}
