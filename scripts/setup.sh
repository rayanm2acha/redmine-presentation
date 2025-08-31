#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Deployment started at $DIR"
cd "$DIR"

### TERRAFORM PHASE
echo "======================"
echo "Running Terraform..."
echo "======================"
cd ../terraform-deployment
terraform init
terraform apply -auto-approve

# Export outputs
terraform output -json > ../ansible-provisioning/inventory/terraform_output.json
cd ..

### INVENTORY GENERATION PHASE
echo "======================"
echo "Generating Ansible inventory..."
echo "======================"

python3 ansible-provisioning/scripts/inventory_generator.py

### ANSIBLE PHASE
echo "======================"
echo "Running Ansible playbook..."
echo "======================"

ANSIBLE_VAULT_PASSWORD_FILE=ansible-provisioning/vault_password.txt

if [ ! -f "$ANSIBLE_VAULT_PASSWORD_FILE" ]; then
  echo "Vault password file not found at $ANSIBLE_VAULT_PASSWORD_FILE"
  exit 1
fi

ANSIBLE_SSH_ARGS="-F $HOME/.ssh/config" ansible-playbook \
  -i ansible-provisioning/inventory/hosts.yml \
  ansible-provisioning/playbooks/site.yml \
  --vault-password-file "$ANSIBLE_VAULT_PASSWORD_FILE"

echo "======================"
echo "Deployment completed successfully!"
echo "======================"