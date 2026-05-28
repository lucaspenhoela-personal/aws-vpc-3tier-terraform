variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente (dev/staging/prod)"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Responsável pelo projeto"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "db_username" {
  description = "Usuário master do RDS"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Senha master do RDS (use AWS Secrets Manager em prod!)"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "Tipo de instância EC2"
  type        = string
  default     = "t2.micro" # Free tier
}

variable "db_instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t3.micro" # Free tier
}