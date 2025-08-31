resource "aws_efs_file_system" "efs" {
  performance_mode = var.performance_mode
  encrypted       = var.encrypted

  tags = merge({
    Name = "${var.vpc_id}-efs"
  }, var.tags)
}

resource "aws_efs_mount_target" "this" {
  for_each           = { for idx, subnet_id in var.subnet_ids : idx => subnet_id }
  file_system_id     = aws_efs_file_system.efs.id
  subnet_id          = each.value
  security_groups    = [aws_security_group.efs_sg.id]
}

resource "aws_security_group" "efs_sg" {
  name        = "${var.vpc_name}-efs-sg"
  description = "Allow NFS access for EFS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}