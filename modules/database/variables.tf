variable "name_prefix" {
  description = "Prefixo para nomear recursos"
  type        = string
}

variable "private_db_subnet_ids" {
  description = "IDs das subnets privadas de banco (mínimo 2 AZs)"
  type        = list(string)
}

variable "db_sg_id" {
  description = "Security Group ID do RDS"
  type        = string
}

variable "db_username" {
  description = "Usuário master do RDS"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Senha master do RDS"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage em GB"
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "Versão do MySQL"
  type        = string
  default     = "8.0"
}