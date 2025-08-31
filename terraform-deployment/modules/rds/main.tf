resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.db_name}-subnet-group"
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier         = var.db_name
  engine             = "postgres"
  engine_version     = "16.8"
  instance_class     = var.instance_class
  allocated_storage  = var.allocated_storage
  db_name           = var.db_name
  username           = var.db_username
  password           = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = var.security_group_ids

  skip_final_snapshot = true
  deletion_protection = false

  multi_az = false

  publicly_accessible = false

  tags = {
    Name = var.db_name
  }
}

resource "aws_security_group" "rds_sg" {
  description = "Security group for RDS instance"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # or pass as a variable
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
  Name = "rds-sg"
}
}