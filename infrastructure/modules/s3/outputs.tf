output "artifacts_bucket_name" {
description = "Name of the artifacts bucket"
value = aws_s3_bucket.artifacts.id
}

output "backups_bucket_name" {
description = "Name of the backups bucket"
value = aws_s3_bucket.backups.id
}

output "logs_bucket_name" {
  description = "Name of the logs bucket"
  value       = aws_s3_bucket.logs.id
}
output "artifacts_bucket_arn" {
description = "ARN of the artifacts bucket"
value = aws_s3_bucket.artifacts.arn
}

output "logs_bucket_arn" {
description = "ARN of the logs bucket"
value = aws_s3_bucket.logs.arn
}

output "backups_bucket_arn" {
description = "ARN of the backups bucket"
value = aws_s3_bucket.backups.arn
}

output "alb_logs_policy" {
  description = "Policy document for ALB logs"
  value       = aws_s3_bucket_policy.logs.policy
}
