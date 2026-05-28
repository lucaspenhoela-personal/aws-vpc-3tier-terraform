output "db_endpoint" {
  description = "Endpoint de conexão do RDS (host:porta)"
  value       = aws_db_instance.main.endpoint
}

output "db_address" {
  description = "Hostname do RDS (sem porta)"
  value       = aws_db_instance.main.address
}

output "db_port" {
  description = "Porta do RDS"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "Nome do banco de dados criado"
  value       = aws_db_instance.main.db_name
}

output "db_instance_id" {
  description = "ID da instância RDS"
  value       = aws_db_instance.main.id
}