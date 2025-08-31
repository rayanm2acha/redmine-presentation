variable "vpc_name" {}

variable "cidr_block" {}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "public_subnets_ids" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.4.0/24"]  # <-- added a second subnet CIDR here
}

variable "private_subnets" {
  type = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b"]  # two AZs
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.4.0/24"] # or your actual subnets
}