resource "aws_secretsmanager_secret" "db_credentials" {
name = "${var.environment}/database/n-credentials"
recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
secret_id = aws_secretsmanager_secret.db_credentials.id
secret_string = jsonencode({
url = "jdbc:postgresql://${var.db_endpoint}/${var.db_name}",
username = var.db_username,
password = var.db_password
})
}

resource "aws_iam_policy" "secrets_access" {
  name        = "${var.project_name}-secrets-access-${var.environment}"
  description = "Policy for accessing secrets in ${var.environment}"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = [
          aws_secretsmanager_secret.db_credentials.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_secrets_access_task_role" {
  role       = var.ecs_task_role_name
  policy_arn = aws_iam_policy.secrets_access.arn
  
  # Ensure role exists first
  depends_on = [var.ecs_task_role]
}
resource "aws_iam_role_policy_attachment" "ecs_task_secrets_access_execution_role" {
  role       = var.ecs_task_execution_role_name
  policy_arn = aws_iam_policy.secrets_access.arn
  
  # Ensure role exists first
  depends_on = [var.ecs_task_role]
}