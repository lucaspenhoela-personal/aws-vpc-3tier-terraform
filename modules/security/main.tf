# SG do ALB (aceita HTTP da internet)
resource "aws_security_group" "alb" {
  name        = "${var.name_prefix}-alb-sg"
  description = "Security group do ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.name_prefix}-alb-sg" }
}

# SG das EC2 (aceita apenas tráfego do ALB)
resource "aws_security_group" "app" {
  name        = "${var.name_prefix}-app-sg"
  description = "Security group das EC2 da aplicacao"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from ALB only"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.name_prefix}-app-sg" }
}

# SG do RDS (aceita apenas das EC2 de app)
resource "aws_security_group" "db" {
  name        = "${var.name_prefix}-db-sg"
  description = "Security group do RDS"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL from app tier only"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  tags = { Name = "${var.name_prefix}-db-sg" }
}