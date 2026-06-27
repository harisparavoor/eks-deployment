resource "aws_ecr_repository" "frontend" {
name = var.frontend_repository_name
image_tag_mutability = "MUTABLE"

image_scanning_configuration {
scan_on_push = true
}
}

resource "aws_ecr_repository" "backend" {
name = var.backend_repository_name
image_tag_mutability = "MUTABLE"

image_scanning_configuration {
scan_on_push = true
}
}

resource "aws_ecr_lifecycle_policy" "frontend" {
repository = aws_ecr_repository.frontend.name

policy = jsonencode({
rules = [
{
rulePriority = 1
description = "Keep last 30 images"
selection = {
tagStatus = "any"
countType = "imageCountMoreThan"
countNumber = 30
}
action = {
type = "expire"
}
}
]
})
}

resource "aws_ecr_lifecycle_policy" "backend" {
repository = aws_ecr_repository.backend.name

policy = jsonencode({
rules = [
{
rulePriority = 1
description = "Keep last 30 images"
selection = {
tagStatus = "any"
countType = "imageCountMoreThan"
countNumber = 30
}
action = {
type = "expire"
}
}
]
})
}
