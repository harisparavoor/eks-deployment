output "pipeline_name" {
  description = "Name of the backend pipeline"
  value       = aws_codepipeline.backend.name
}

output "codebuild_project_name" {
  description = "Name of the backend CodeBuild project"
  value       = aws_codebuild_project.backend_build.name
}
