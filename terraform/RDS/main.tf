==============================================================================================================









==========================================================================================================================
provider "aws" {
  region = "us-west-2"
}

# 1. VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "oracle19c-vpc"
  }
}

# 2. Subnets
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "subnet-a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "subnet-b"
  }
}

# 3. Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "oracle19c-gateway"
  }
}

# 4. Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "oracle19c-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.rt.id
}

# 5. Security Group
resource "aws_security_group" "rds_sg" {
  name        = "oracle19c-sg"
  description = "Allow Oracle traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Oracle default port"
    from_port   = 1521
    to_port     = 1521
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For testing; restrict in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "oracle19c-sg"
  }
}

# 6. Subnet Group
resource "aws_db_subnet_group" "oracle_subnet_group" {
  name       = "oracle-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  tags = {
    Name = "oracle-db-subnet-group"
  }
}

# 7. RDS Oracle 19c
resource "aws_db_instance" "oracle_19c" {
  identifier              = "oracle19c-db"
  engine                  = "oracle-se2"
  engine_version          = "19.0.0.0.ru-2023-10.rur-2023-10.r1" # Confirm with AWS account
  instance_class          = "db.m5.large"
  allocated_storage       = 100
  storage_type            = "gp2"
  db_name                 = "ORCL"
  username                = var.db_username
  password                = var.db_password
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.oracle_subnet_group.name
  license_model           = "bring-your-own-license"
  backup_retention_period = 7
  skip_final_snapshot     = true
  publicly_accessible     = true
  multi_az                = false

  tags = {
    Name = "Oracle19cRDS"
  }
}
=============================================================================
📄 variables.tf
=============================
variable "db_username" {
  description = "Master DB username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}
=====================================================================================================================
terraform apply -var="db_password=YourSecurePassword123!"

