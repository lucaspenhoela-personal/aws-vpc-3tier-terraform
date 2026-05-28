output "alb_dns_name" {
  description = "🌐 URL pública do ALB — abra no navegador para testar"
  value       = module.alb.alb_dns_name
}

output "vpc_id" {
  description = "ID da VPC criada"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR da VPC"
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas"
  value       = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "IDs das subnets privadas de aplicação"
  value       = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  description = "IDs das subnets privadas de banco"
  value       = module.vpc.private_db_subnet_ids
}

output "db_endpoint" {
  description = "Endpoint do RDS (sensível)"
  value       = module.database.db_endpoint
  sensitive   = true
}

output "autoscaling_group_name" {
  description = "Nome do ASG (útil para deploys)"
  value       = module.compute.autoscaling_group_name
}