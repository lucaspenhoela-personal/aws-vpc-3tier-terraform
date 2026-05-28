resource "aws_db_subnet_group" "main" {
  name       = "${var.name_prefix}-db-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = { Name = "${var.name_prefix}-db-subnet-group" }
}

resource "aws_db_instance" "main" {
  identifier        = "${var.name_prefix}-mysql"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.db_instance_class
  allocated_storage = 20
  storage_type      = "gp2"
  storage_encrypted = true

  db_name  = "appdb"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_sg_id]

  multi_az                = false # Free tier
  publicly_accessible     = false
  skip_final_snapshot     = true # Apenas para dev
  backup_retention_period = 1
  deletion_protection     = false # Apenas para dev

  tags = { Name = "${var.name_prefix}-rds" }
}