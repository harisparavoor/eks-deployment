output "pipeline_name" {
  description = "Name of the frontend pipeline"
  value       = aws_codepipeline.frontend.name
}

output "codebuild_project_name" {
  description = "Name of the frontend CodeBuild project"
  value       = aws_codebuild_project.frontend_build.name
}
