variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "public_subnet_1_id" {
  description = "The ID of the first public subnet"
  type        = string
}

variable "public_subnet_2_id" {
  description = "The ID of the second public subnet"
  type        = string
}

variable "acm_certificate_arn" {
  type = string
}

variable "redmine_instance_id" {
  type = string
}

variable "monitoring_instance_id" {
  type = string
}

variable "redmine_instance_sg_id" {
  description = "Security Group ID of the Redmine EC2 instance"
  type        = string
}