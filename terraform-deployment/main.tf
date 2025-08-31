provider "aws" {
  region = var.aws_region
}

module "network" {
  source        = "./modules/network"
  vpc_name      = var.vpc_name
  cidr_block    = var.cidr_block
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = ["eu-west-3a", "eu-west-3b"]
}

module "bastion" {
  source           = "./modules/bastion"
  instance_type    = var.instance_type
  key_name         = var.key_name
  subnet_id        = module.network.public_subnet_ids[0]
  vpc_id           = module.network.vpc_id
  allowed_ssh_cidrs = [var.local_ip_cidr]
  redmine_private_key = var.redmine_private_key
}

module "ec2_redmine" {
  source         = "./modules/ec2_redmine"
  instance_type  = var.instance_type
  key_name       = var.key_name
  subnet_id      = module.network.private_subnet_ids[0]
  vpc_id         = module.network.vpc_id
  bastion_sg_id  = module.bastion.security_group_id
}

module "ec2_monitoring" {
  source         = "./modules/ec2_monitoring"
  instance_type  = var.instance_type
  key_name       = var.key_name
  subnet_id      = module.network.private_subnet_ids[1]
  vpc_id         = module.network.vpc_id
  bastion_sg_id  = module.bastion.security_group_id
}

module "alb" {
  source               = "./modules/alb"
  acm_certificate_arn  = var.acm_certificate_arn
  vpc_id               = module.network.vpc_id
  public_subnet_ids    = module.network.public_subnet_ids
  public_subnet_1_id   = module.network.public_subnet_ids[0]
  public_subnet_2_id   = module.network.public_subnet_ids[1]
  redmine_instance_id  = module.ec2_redmine.instance_id
  redmine_instance_sg_id = module.ec2_redmine.security_group_id  # <-- this is what’s missing
  monitoring_instance_id = module.ec2_monitoring.instance_id
}

module "rds" {
  source = "./modules/rds"  # path to your RDS module

  vpc_id            = module.network.vpc_id               # VPC ID output from your network module
  subnet_ids        = module.network.private_subnet_ids    # Private subnets for RDS placement   # Security groups allowing Redmine access
  security_group_ids = [module.rds.rds_sg_id]
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
}

module "efs" {
  source            = "./modules/efs"
  vpc_id            = module.network.vpc_id
  vpc_name          = var.vpc_name
  subnet_ids        = module.network.private_subnet_ids
  tags              = var.common_tags
}

module "gitlab-runner" {
  source        = "./modules/gitlab-runner"
  vpc_id        = module.network.vpc_id
  subnet_id     = module.network.public_subnet_ids[0]
  ami_id        = data.aws_ami.ubuntu.id
  key_name      = var.key_name
  allowed_ssh_ip = var.local_ip_cidr
  tags          = var.common_tags
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}