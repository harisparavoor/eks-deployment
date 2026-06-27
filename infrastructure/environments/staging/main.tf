module "infrastructure" {
source = "../../"

environment = "${env}"
project_name = var.project_name
aws_region = var.aws_region
vpc_cidr_block = var.vpc_cidr_block
db_name = var.db_name
db_username = var.db_username
db_password = var.db_password
domain_name = var.domain_name
route53_zone_id = var.route53_zone_id
github_owner = var.github_owner
github_repo_frontend = var.github_repo_frontend
github_repo_backend = var.github_repo_backend
github_branch = var.github_branch
github_token = var.github_token
github_webhook_token = var.github_webhook_token
}
