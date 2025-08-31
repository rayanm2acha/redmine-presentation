output "endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.rds_instance.endpoint
}

output "port" {
  description = "RDS port"
  value       = aws_db_instance.rds_instance.port
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.rds_instance.db_name
}

output "username" {
  description = "Master username"
  value       = aws_db_instance.rds_instance.username
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "password" {
  description = "Master password"
  value       = aws_db_instance.rds_instance.password
  sensitive   = true
}