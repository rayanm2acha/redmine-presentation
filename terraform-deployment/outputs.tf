output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

output "redmine_private_ip" {
  value = module.ec2_redmine.redmine_private_ip
}

output "monitoring_private_ip" {
  value = module.ec2_monitoring.monitoring_private_ip
}

output "ansible_inventory" {
  value = {
    bastion = {
      hosts = [module.bastion.bastion_public_ip]
      vars  = {}
    }
    redmine = {
      hosts = [module.ec2_redmine.redmine_private_ip]
      vars  = {}
    }
    monitoring = {
      hosts = [module.ec2_monitoring.monitoring_private_ip]
      vars  = {}
    }
    _meta = {
      hostvars = {
        "${module.bastion.bastion_public_ip}" = {
          ansible_host = module.bastion.bastion_public_ip
          ansible_user = "ubuntu"
          ansible_ssh_private_key_file = "scripts/redmine-key2.pem"
        }
        "${module.ec2_redmine.redmine_private_ip}" = {
          ansible_host = module.ec2_redmine.redmine_private_ip
          ansible_user = "ubuntu"
        }
        "${module.ec2_monitoring.monitoring_private_ip}" = {
          ansible_host = module.ec2_monitoring.monitoring_private_ip
          ansible_user = "ubuntu"
        }
      }
    }
  }
  description = "Ansible dynamic inventory for Bastion, Redmine, and Monitoring"
}

output "gitlab_runner_public_ip" {
  value = module.gitlab-runner.gitlab_runner_public_ip
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "rds_db_name" {
  value = module.rds.db_name
}

output "rds_username" {
  value = module.rds.username
}

output "rds_password" {
  value = module.rds.password
  sensitive = true
}