#!/usr/bin/env python3

import os
import json
import yaml

# Load terraform outputs from file argument
terraform_output_path = "terraform-deployment/terraform_outputs.json"
inventory_output_path = "ansible-provisioning/inventory/hosts.yml"

with open(terraform_output_path, "r") as f:
    outputs = json.load(f)

bastion_ip = outputs["bastion_public_ip"]["value"]
redmine_ip = outputs["redmine_private_ip"]["value"]
monitoring_ip = outputs["monitoring_private_ip"]["value"]

# Build inventory dictionary
inventory = {
    "all": {
        "children": {
            "bastion": {
                "hosts": {
                    "bastion": {
                        "ansible_host": bastion_ip,
                        "ansible_user": "ubuntu"
                    }
                }
            },
            "monitoring": {
                "hosts": {
                    "monitoring-instance": {
                        "ansible_host": monitoring_ip,
                        "ansible_user": "ubuntu",
                        "ansible_ssh_common_args": f"-o ProxyJump=ubuntu@{bastion_ip}"
                    }
                }
            },
            "redmine": {
                "hosts": {
                    "redmine-instance": {
                        "ansible_host": redmine_ip,
                        "ansible_user": "ubuntu",
                        "ansible_ssh_common_args": f"-o ProxyJump=ubuntu@{bastion_ip}"
                    }
                }
            }
        }
    }
}

# Write inventory file
with open(inventory_output_path, "w") as f:
    yaml.dump(inventory, f, default_flow_style=False)

print("✅ Inventory generated:", inventory_output_path)

terraform_vars_path = os.path.join(os.path.dirname(inventory_output_path), "group_vars/all/terraform.yml")
os.makedirs(os.path.dirname(terraform_vars_path), exist_ok=True)

# Write terraform vars
terraform_vars = {
    "redmine_db_host": outputs["rds_endpoint"]["value"],
    "redmine_db_name": outputs["rds_db_name"]["value"],
    "redmine_db_user": outputs["rds_username"]["value"]
}

with open(terraform_vars_path, "w") as tf_file:
    yaml.dump(terraform_vars, tf_file, default_flow_style=False)

print("✅ Terraform vars generated:", terraform_vars_path)