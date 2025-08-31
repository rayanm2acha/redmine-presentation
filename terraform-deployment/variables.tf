variable "aws_region" {}
variable "key_name" {}
variable "instance_type" {}
variable "local_ip_cidr" {}

variable "vpc_name" {}
variable "cidr_block" {}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "availability_zones" {
  type = list(string)
}

variable "redmine_private_key" {
  description = "The private key used to SSH between instances"
  type        = string
  sensitive   = true
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate for the ALB HTTPS listener"
  type        = string
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]  # your two public subnets here
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "redmine"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "redmineuser"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for EFS"
  type        = string
}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed to access certain resources"
  type        = list(string)
  default     = ["10.0.0.0/16"]  # Or your actual CIDR blocks
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {
    Project = "redmine"
    Owner   = "rayan"
  }
}
