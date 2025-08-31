output "efs_id" {
  description = "EFS file system ID"
  value       = aws_efs_file_system.efs.id
}

output "efs_dns_name" {
  description = "EFS DNS name for mounting"
  value       = aws_efs_file_system.efs.dns_name
}
