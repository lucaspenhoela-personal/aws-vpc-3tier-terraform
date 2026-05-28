variable "name_prefix" {
  description = "Prefixo para nomear recursos"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instância EC2 (ex: t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "app_sg_id" {
  description = "Security Group ID das EC2 da aplicação"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs das subnets privadas onde as EC2 serão deployadas"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN do Target Group do ALB para registrar as EC2"
  type        = string
}

variable "db_endpoint" {
  description = "Endpoint do RDS (passado como variável de ambiente para a EC2)"
  type        = string
}

variable "min_size" {
  description = "Tamanho mínimo do Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Tamanho máximo do Auto Scaling Group"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Capacidade desejada do ASG"
  type        = number
  default     = 2
}