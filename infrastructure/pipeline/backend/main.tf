resource "aws_codepipeline" "backend" {
  name          = "${var.project_name}-${var.environment}-backend-pipeline"
  role_arn      = aws_iam_role.codepipeline_role.arn
  pipeline_type = "V2"

  artifact_store {
    location = var.artifacts_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.codestar_connection_arn
        FullRepositoryId = "${var.github_owner}/${var.github_repo_backend}"
        BranchName       = var.github_branch
        #DetectChanges    = "false"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.backend_build.name
      }
    }
  }

  trigger {
    provider_type = "CodeStarSourceConnection"

    git_configuration {
      source_action_name = "Source"

      push {
        branches {
          includes = [var.github_branch]
        }
      }
    }
  }

}

# CodeBuild Project
resource "aws_codebuild_project" "backend_build" {
  name          = "${var.project_name}-${var.environment}-backend-build"
  description   = "Backend build project"
  build_timeout = "10"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "REPOSITORY_URI"
      value = var.ecr_repository_url
    }
    environment_variable {
      name  = "Backend_App"
      value = var.backend_appname
    }
    environment_variable {
      name  = "Frontend_App"
      value = var.frontend_appname
    }
    environment_variable {
      name  = "Backend_app_tg_arn"
      value = var.backend_target_group_arn
    }
    environment_variable {
      name  = "VPC_ID"
      value = var.vpc_id
    }

    environment_variable {
      name  = "SUBNET_IDS"
      value = var.private_subnet_ids != null ? join(",", var.private_subnet_ids) : ""
    }
    environment_variable {
      name  = "AWS_REGION"
      value = var.aws_region
    }

    environment_variable {
      name  = "ALB_CONTROLLER_ROLE_ARN"
      value = var.alb_controller_role_arn
    }
    environment_variable {
      name  = "CLUSTER_NAME"
      value = var.cluster_name
    }


    environment_variable {
      name  = "NAMESPACE"
      value = "default"
    }
    environment_variable {
      name  = "ENVIRONMENT"
      value = var.environment
    }

  }

  source {
    type = "CODEPIPELINE"
    #buildspec = file("${path.module}/buildspec.yml")
  }

  logs_config {
    cloudwatch_logs {
      group_name = "/codebuild/${var.project_name}-${var.environment}-backend"
    }
  }
}

# IAM Role for CodePipeline
resource "aws_iam_role" "codepipeline_role" {
  name = "${var.project_name}-${var.environment}-backend-pipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "codepipeline.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy" "codepipeline_codestar_policy" {
  name = "${var.project_name}-${var.environment}-backend-codestar-pipeline-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["codestar-connections:UseConnection"],
        Resource = var.codestar_connection_arn
      }
    ]
  })
}
resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${var.project_name}-${var.environment}-backend-pipeline-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning",
          "s3:PutObjectAcl",
        "s3:PutObject"]
        Resource = [
          var.artifacts_bucket_arn,
        "${var.artifacts_bucket_arn}/*"]
      },
      {
        Effect   = "Allow"
        Action   = ["codebuild:BatchGetBuilds", "codebuild:StartBuild"]
        Resource = ["*"]
      },
      {
        Effect   = "Allow"
        Action   = ["iam:PassRole"]
        Resource = ["*"]
        Condition = {
          StringLike = {
            "iam:PassedToService" = "codebuild.amazonaws.com"
          }
        }
      }
    ]
  })
}

# IAM Role for CodeBuild
resource "aws_iam_role" "codebuild_role" {
  name = "${var.project_name}-${var.environment}-backend-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "codebuild.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "${var.project_name}-${var.environment}-backend-codebuild-policy"
  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = ["*"]
      },
      {
        Effect = "Allow"
        Action = ["s3:GetObject", "s3:GetObjectVersion", "s3:PutObject"]
        Resource = [
          var.artifacts_bucket_arn,
        "${var.artifacts_bucket_arn}/*"]
      },
      {
        Effect   = "Allow"
        Action   = ["ecr:GetAuthorizationToken", "ecr:BatchCheckLayerAvailability", "ecr:GetDownloadUrlForLayer", "ecr:GetRepositoryPolicy", "ecr:DescribeRepositories", "ecr:ListImages", "ecr:DescribeImages", "ecr:BatchGetImage", "ecr:InitiateLayerUpload", "ecr:UploadLayerPart", "ecr:CompleteLayerUpload", "ecr:PutImage"]
        Resource = ["*"]
      },
      {
        Effect   = "Allow"
        Action   = ["secretsmanager:GetSecretValue"]
        Resource = ["*"]
      },
      {
        Effect   = "Allow"
        Action   = ["eks:DescribeCluster"]
        Resource = ["*"]
      }
    ]
  })
}

resource "aws_eks_access_entry" "codebuild" {
  cluster_name  = var.cluster_name
  principal_arn = aws_iam_role.codebuild_role.arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "codebuild_cluster_admin" {
  cluster_name  = var.cluster_name
  principal_arn = aws_iam_role.codebuild_role.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.codebuild]
}
