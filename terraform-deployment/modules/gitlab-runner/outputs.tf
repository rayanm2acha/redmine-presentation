output "gitlab_runner_public_ip" {
  value = aws_instance.gitlab-runner.public_ip
}