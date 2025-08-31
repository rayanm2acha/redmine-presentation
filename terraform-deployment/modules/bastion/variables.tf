variable "instance_type" {
  type        = string
  description = "EC2 instance type for bastion"
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name"
}

variable "subnet_id" {
  type        = string
  description = "Public subnet ID"
}

variable "vpc_id" {
  type = string
}

variable "allowed_ssh_cidrs" {
  type        = list(string)
  description = "List of CIDRs allowed to SSH into bastion"
}

variable "redmine_private_key" {
  description = "The content of redmine-key2.pem"
  type        = string
  sensitive   = true
}