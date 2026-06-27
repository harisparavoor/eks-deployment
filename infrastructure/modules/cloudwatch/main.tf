resource "aws_cloudwatch_log_group" "frontend" {
name = "/ecs/${var.ecs_cluster_name}/${var.frontend_service_name}"
retention_in_days = var.environment == "prod" ? 30 : 7
}

resource "aws_cloudwatch_log_group" "backend" {
name = "/ecs/${var.ecs_cluster_name}/${var.backend_service_name}"
retention_in_days = var.environment == "prod" ? 30 : 7
}

resource "aws_cloudwatch_metric_alarm" "frontend_cpu" {
alarm_name = "${var.frontend_service_name}-high-cpu"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "CPUUtilization"
namespace = "AWS/ECS"
period = "120"
statistic = "Average"
threshold = "80"
alarm_description = "This metric monitors ECS CPU utilization for frontend"
alarm_actions = var.environment == "prod" ? [var.sns_topic_arn] : []

dimensions = {
ClusterName = var.ecs_cluster_name
ServiceName = var.frontend_service_name
}
}

resource "aws_cloudwatch_metric_alarm" "backend_cpu" {
alarm_name = "${var.backend_service_name}-high-cpu"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "CPUUtilization"
namespace = "AWS/ECS"
period = "120"
statistic = "Average"
threshold = "80"
alarm_description = "This metric monitors ECS CPU utilization for backend"
alarm_actions = var.environment == "prod" ? [var.sns_topic_arn] : []

dimensions = {
ClusterName = var.ecs_cluster_name
ServiceName = var.backend_service_name
}
}

resource "aws_cloudwatch_dashboard" "main" {
dashboard_name = "${var.ecs_cluster_name}-dashboard"

dashboard_body = jsonencode({
widgets = [
{
type = "metric"
x = 0
y = 0
width = 12
height = 6

    properties = {
      metrics = [
        [
          "AWS/ECS",
          "CPUUtilization",
          "ClusterName",
          var.ecs_cluster_name,
          "ServiceName",
          var.frontend_service_name
        ],
        [
          "AWS/ECS",
          "CPUUtilization",
          "ClusterName",
          var.ecs_cluster_name,
          "ServiceName",
          var.backend_service_name
        ]
      ]
      period = 300
      stat   = "Average"
      region = "us-east-1"
      title  = "ECS CPU Utilization"
    }
  },
  {
    type   = "metric"
    x      = 12
    y      = 0
    width  = 12
    height = 6

    properties = {
      metrics = [
        [
          "AWS/ECS",
          "MemoryUtilization",
          "ClusterName",
          var.ecs_cluster_name,
          "ServiceName",
          var.frontend_service_name
        ],
        [
          "AWS/ECS",
          "MemoryUtilization",
          "ClusterName",
          var.ecs_cluster_name,
          "ServiceName",
          var.backend_service_name
        ]
      ]
      period = 300
      stat   = "Average"
      region = "us-east-1"
      title  = "ECS Memory Utilization"
    }
  }
]
})
}
