variable "vpc_id" {}
variable "subnet_id" {}
variable "ami_id" {}
variable "instance_type" { default = "t3.micro" }
variable "key_name" {}
variable "allowed_ssh_ip" {}
variable "tags" {
  type = map(string)
  default = {}
}