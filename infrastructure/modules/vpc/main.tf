resource "aws_vpc" "main" {
cidr_block = var.cidr_block
enable_dns_support = true
enable_dns_hostnames = true

tags = {
Name = "${var.project_name}-${var.environment}-vpc"
}
}

resource "aws_internet_gateway" "main" {
vpc_id = aws_vpc.main.id

tags = {
Name = "${var.project_name}-${var.environment}-igw"
}
}

resource "aws_subnet" "public" {
count = 3

vpc_id = aws_vpc.main.id
cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
availability_zone = element(data.aws_availability_zones.available.names, count.index)

tags = {
Name = "${var.project_name}-${var.environment}-public-${count.index + 1}"
}
}

resource "aws_subnet" "private" {
count = 3

vpc_id = aws_vpc.main.id
cidr_block = cidrsubnet(var.cidr_block, 8, count.index + 3)
availability_zone = element(data.aws_availability_zones.available.names, count.index)

tags = {
Name = "${var.project_name}-${var.environment}-private-${count.index + 1}"
}
}

resource "aws_route_table" "public" {
vpc_id = aws_vpc.main.id

route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.main.id
}

tags = {
Name = "${var.project_name}-${var.environment}-public-rt"
}
}

resource "aws_route_table_association" "public" {
count = 3

subnet_id = aws_subnet.public[count.index].id
route_table_id = aws_route_table.public.id
}

/*resource "aws_eip" "nat" {
count = 3

tags = {
Name = "${var.project_name}-${var.environment}-nat-eip-${count.index + 1}"
}
}

resource "aws_nat_gateway" "main" {
count = 3

allocation_id = aws_eip.nat[count.index].id
subnet_id = aws_subnet.public[count.index].id

tags = {
Name = "${var.project_name}-${var.environment}-nat-${count.index + 1}"
}
}

resource "aws_route_table" "private" {
count = 3

vpc_id = aws_vpc.main.id

route {
cidr_block = "0.0.0.0/0"
nat_gateway_id = aws_nat_gateway.main[count.index].id
}

tags = {
Name = "${var.project_name}-${var.environment}-private-rt-${count.index + 1}"
}
}
*/
# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  #vpc = true
  tags = {
    Name        = "${var.project_name}-${var.environment}-nat-eip"
  }
}

# Create Single NAT Gateway in the first public subnet
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name        = "${var.project_name}-${var.environment}-nat"
  }
}

# Private Route Tables use the single NAT Gateway
resource "aws_route_table" "private" {
  count  = 3
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-private-rt-${count.index + 1}"
  }
}
resource "aws_route_table_association" "private" {
count = 3

subnet_id = aws_subnet.private[count.index].id
route_table_id = aws_route_table.private[count.index].id
}

resource "aws_security_group" "alb" {
name = "${var.project_name}-${var.environment}-alb-sg"
description = "Security group for ALB"
vpc_id = aws_vpc.main.id

ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 443
to_port = 443
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}

tags = {
Name = "${var.project_name}-${var.environment}-alb-sg"
}
}

resource "aws_security_group" "ecs" {
name = "${var.project_name}-${var.environment}-ecs-sg"
description = "Security group for ECS tasks"
vpc_id = aws_vpc.main.id

ingress {
from_port = 0
to_port = 65535
protocol = "tcp"
security_groups = [aws_security_group.alb.id]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}

tags = {
Name = "${var.project_name}-${var.environment}-ecs-sg"
}
}

resource "aws_security_group" "rds" {
name = "${var.project_name}-${var.environment}-rds-sg"
description = "Security group for RDS"
vpc_id = aws_vpc.main.id

ingress {
from_port = 5432
to_port = 5432
protocol = "tcp"
security_groups = [aws_security_group.ecs.id]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}

tags = {
Name = "${var.project_name}-${var.environment}-rds-sg"
}
}

data "aws_availability_zones" "available" {
state = "available"
}
