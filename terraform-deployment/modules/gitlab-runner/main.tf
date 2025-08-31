resource "aws_instance" "gitlab-runner" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.gitlab_runner_sg.id]
  key_name                    = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y curl wget git
    curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | bash
    apt-get install -y gitlab-runner

    # Grant gitlab-runner user passwordless sudo rights
    usermod -aG sudo gitlab-runner
    echo "gitlab-runner ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/gitlab-runner
    chmod 440 /etc/sudoers.d/gitlab-runner
  EOF

  tags = merge(
  {
    Name = "gitlab-runner"
  },
  var.tags
 )
}

resource "aws_security_group" "gitlab_runner_sg" {
  name        = "gitlab-runner-sg"
  description = "Security group for GitLab runner"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH from admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "gitlab-runner-sg"
    },
    var.tags
  )
}