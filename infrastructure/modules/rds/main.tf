resource "aws_db_subnet_group" "main" {
name = "${var.environment}-db-subnet-group"
subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "main" {
identifier = "${var.environment}-db-instance"
allocated_storage = 20
storage_type = "gp2"
engine = "postgres"
#engine_version = "13.7"
instance_class = "db.t3.micro"
db_name = var.db_name
username = var.db_username
password = var.db_password
#parameter_group_name = "default.postgres13"
skip_final_snapshot = true
publicly_accessible = false
vpc_security_group_ids = [var.rds_security_group_id]
db_subnet_group_name = aws_db_subnet_group.main.name
multi_az = var.environment == "prod" ? true : false
storage_encrypted = true
}
