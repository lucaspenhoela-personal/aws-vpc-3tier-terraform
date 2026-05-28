variable "name_prefix" {
  description = "Prefixo para nomear recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde o ALB será criado"
  type        = string
}

variable "alb_sg_id" {
  description = "Security Group ID do ALB"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs das subnets públicas onde o ALB será deployado"
  type        = list(string)
}