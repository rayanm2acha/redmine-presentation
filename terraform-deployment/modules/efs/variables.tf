variable "vpc_id" {
  type = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where mount targets will be created"
  type        = list(string)
}

variable "performance_mode" {
  description = "EFS performance mode"
  type        = string
  default     = "generalPurpose"
}

variable "encrypted" {
  description = "Enable encryption at rest"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags for the EFS"
  type        = map(string)
  default     = {}
}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed to access EFS"
  type        = list(string)
  default     = ["10.0.0.0/16"]  # Adjust based on your VPC CIDR or specifics
}