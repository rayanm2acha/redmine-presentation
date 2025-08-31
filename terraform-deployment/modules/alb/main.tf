# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Security group for Application Load Balancer"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Allow ALB to access Redmine instance on port 3000
resource "aws_security_group_rule" "allow_alb_to_redmine" {
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  security_group_id        = var.redmine_instance_sg_id
  source_security_group_id = aws_security_group.alb_sg.id
}

# Create ALB
resource "aws_lb" "app_alb" {
  name               = "redmine-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    var.public_subnet_1_id,
    var.public_subnet_2_id
  ]
  enable_deletion_protection = false
  
  tags = {
    Environment = "redmine"
  }
}

# Target group for Redmine (port 3000)
resource "aws_lb_target_group" "redmine_tg" {
  name        = "redmine-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    port                = "3000"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
}

# Attach Redmine instance to Redmine target group
resource "aws_lb_target_group_attachment" "redmine_tg_attachment" {
  target_group_arn = aws_lb_target_group.redmine_tg.arn
  target_id        = var.redmine_instance_id
  port             = 3000
}

# Target group for Monitoring (Grafana - port 3000)
resource "aws_lb_target_group" "monitoring_tg" {
  name        = "monitoring-tg"
  port        = 3001
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    port                = "3000"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
}

# ALB Listener for HTTP (port 80)
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Use HTTPS"
      status_code  = "400"
    }
  }
}

# ALB Listener for HTTPS (port 443) - adjust later to add certificate ARN
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "443"
  protocol          = "HTTPS"

  ssl_policy       = "ELBSecurityPolicy-2016-08"
  certificate_arn  = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.redmine_tg.arn
  }
}

# Listener rules - route /grafana to monitoring_tg
resource "aws_lb_listener_rule" "grafana_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.monitoring_tg.arn
  }

  condition {
    path_pattern {
      values = ["/grafana*"]
    }
  }
}