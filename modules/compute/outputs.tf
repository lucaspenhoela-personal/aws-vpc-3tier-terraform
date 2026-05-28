output "autoscaling_group_name" {
  description = "Nome do Auto Scaling Group"
  value       = aws_autoscaling_group.app.name
}

output "autoscaling_group_arn" {
  description = "ARN do ASG"
  value       = aws_autoscaling_group.app.arn
}

output "launch_template_id" {
  description = "ID do Launch Template"
  value       = aws_launch_template.app.id
}