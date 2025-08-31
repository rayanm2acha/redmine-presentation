output "private_ip" {
  value = aws_instance.redmine.private_ip
}

output "redmine_private_ip" {
  value = aws_instance.redmine.private_ip
}

output "instance_id" {
  description = "The ID of the Redmine EC2 instance"
  value       = aws_instance.redmine.id
}