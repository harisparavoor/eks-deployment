
module "vpc" {
source = "./modules/vpc"
cidr_block = var.vpc_cidr_block
environment = var.environment
project_name = var.project_name
}

module "rds" {
source = "./modules/rds"
vpc_id = module.vpc.vpc_id
subnet_ids = module.vpc.private_subnet_ids
environment = var.environment
db_name = var.db_name
db_username = var.db_username
db_password = var.db_password
rds_security_group_id = module.vpc.rds_security_group_id
}

module "ecr" {
source = "./modules/ecr"
environment = var.environment
frontend_repository_name = "${var.project_name}-frontend-${var.environment}"
backend_repository_name = "${var.project_name}-backend-${var.environment}"
}


module "alb" {
source = "./modules/alb"
vpc_id = module.vpc.vpc_id
public_subnet_ids = module.vpc.public_subnet_ids
environment = var.environment
domain_name = var.domain_name
acm_certificate_arn = module.acm.certificate_arn
#route53_zone_id = var.route53_zone_id
alb_security_group_id = module.vpc.alb_security_group_id
logs_bucket_name = module.s3.logs_bucket_name
alb_logs_policy  = module.s3.alb_logs_policy
depends_on = [module.acm]
}

module "acm" {
source = "./modules/acm"
domain_name = var.domain_name
environment = var.environment
route53_zone_id = var.route53_zone_id
}

module "ecs" {
source = "./modules/ecs"
vpc_id = module.vpc.vpc_id
environment = var.environment
project_name = var.project_name
db_secret_arn = module.secrets_manager.db_secret_arn
ecr_repository_url = module.ecr.frontend_repository_url
backend_repository_url = module.ecr.backend_repository_url
alb_security_group_id = module.vpc.alb_security_group_id
private_subnet_ids = module.vpc.private_subnet_ids
ecs_security_group_id = module.vpc.ecs_security_group_id
alb_listener_arn     = module.alb.frontend_https_listener_arn
frontend_blue_target_group_name  = module.alb.frontend_blue_target_group_name
frontend_green_target_group_name = module.alb.frontend_green_target_group_name
frontend_blue_target_group_arn  = module.alb.frontend_blue_target_group_arn
frontend_green_target_group_arn = module.alb.frontend_green_target_group_arn
backend_blue_target_group_name  = module.alb.backend_blue_target_group_name
backend_blue_target_group_arn  = module.alb.backend_blue_target_group_arn
backend_green_target_group_name = module.alb.backend_green_target_group_name 
backend_green_target_group_arn = module.alb.backend_green_target_group_arn
#alb_target_group_arn = module.alb.frontend_target_group_arn
#backend_target_group_arn = module.alb.backend_target_group_arn
#frontend_target_group_arn = module.alb.frontend_target_group_arn
}

module "s3" {
source = "./modules/s3"
environment = var.environment
project_name = var.project_name
}

module "cloudwatch" {
source = "./modules/cloudwatch"
environment = var.environment
ecs_cluster_name = module.ecs.ecs_cluster_name
frontend_service_name = module.ecs.frontend_service_name
backend_service_name = module.ecs.backend_service_name
}

module "secrets_manager" {
source = "./modules/secrets_manager"
project_name = var.project_name
environment = var.environment
db_endpoint = module.rds.db_endpoint
db_name = var.db_name
db_username = var.db_username
db_password = var.db_password
ecs_task_role_name = module.ecs.ecs_task_role_name
ecs_task_role      = module.ecs.ecs_task_role
ecs_task_execution_role_name = module.ecs.ecs_task_execution_role_name
}

module "frontend_pipeline" {
source = "./pipeline/frontend"
project_name = var.project_name
environment = var.environment
domain_name = var.domain_name
artifacts_bucket_arn = module.s3.artifacts_bucket_arn
artifacts_bucket_name = module.s3.artifacts_bucket_name
github_owner = var.github_owner
github_repo_frontend = var.github_repo_frontend
github_branch = var.github_branch
github_token = var.github_token
github_webhook_token = var.github_webhook_token
ecr_repository_url = module.ecr.frontend_repository_url
codedeploy_app_name = "${var.project_name}-frontend-${var.environment}"
codedeploy_deployment_group = "${var.project_name}-frontend-${var.environment}-dg"
codestar_connection_arn = var.codestar_connection_arn
alb_listener_arn     = module.alb.frontend_https_listener_arn
frontend_blue_target_group_name  = module.alb.frontend_blue_target_group_name
frontend_green_target_group_name = module.alb.frontend_green_target_group_name
frontend_task_definition_arn = module.ecs.frontend_task_definition_arn
alb_dns_name = module.alb.alb_dns_name
}

module "backend_pipeline" {
source = "./pipeline/backend"
project_name = var.project_name
environment = var.environment
artifacts_bucket_name = module.s3.artifacts_bucket_name
artifacts_bucket_arn = module.s3.artifacts_bucket_arn
github_owner = var.github_owner
github_repo_backend = var.github_repo_backend
github_branch = var.github_branch
github_token = var.github_token
github_webhook_token = var.github_webhook_token
ecr_repository_url = module.ecr.backend_repository_url
codedeploy_app_name = "${var.project_name}-backend-${var.environment}"
codedeploy_deployment_group = "${var.project_name}-backend-${var.environment}-dg"
codestar_connection_arn = var.codestar_connection_arn
alb_listener_arn     = module.alb.frontend_https_listener_arn
backend_blue_target_group_name  = module.alb.backend_blue_target_group_name
backend_green_target_group_name = module.alb.backend_green_target_group_name
backend_task_definition_arn = module.ecs.backend_task_definition_arn
}
