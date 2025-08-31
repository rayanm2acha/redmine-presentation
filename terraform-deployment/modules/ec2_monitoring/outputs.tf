output "private_ip" {
  value = aws_instance.monitoring.private_ip
}

output "monitoring_private_ip" {
  value = aws_instance.monitoring.private_ip
}

output "instance_id" {
  description = "The ID of the Monitoring EC2 instance"
  value       = aws_instance.monitoring.id
}