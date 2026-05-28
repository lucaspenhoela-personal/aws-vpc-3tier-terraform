output "alb_dns_name" {
  description = "DNS público do Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_arn" {
  description = "ARN do ALB"
  value       = aws_lb.main.arn
}

output "alb_zone_id" {
  description = "Zone ID do ALB (útil para Route 53 alias)"
  value       = aws_lb.main.zone_id
}

output "target_group_arn" {
  description = "ARN do Target Group (usado pelo Auto Scaling)"
  value       = aws_lb_target_group.app.arn
}