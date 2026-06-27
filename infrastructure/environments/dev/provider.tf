provider "aws" {
  region  = var.aws_region
  profile = "harips"
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
    }
  }
}