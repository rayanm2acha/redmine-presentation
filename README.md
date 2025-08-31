# Redmine Infrastructure Deployment 🚀

This project demonstrates the **end-to-end deployment of Redmine** with a fully monitored and reproducible infrastructure.  
It was built as a professional DevOps case study to showcase **Infrastructure as Code (IaC)**, **automation with Ansible**, and **observability with Prometheus/Grafana**.

---

## 📌 Features
- **Infrastructure as Code (Terraform)**
  - AWS deployment (VPC, EC2, RDS, S3, EFS…)
  - Modular design (`network`, `rds`, `ec2_redmine`, `monitoring`, etc.)
- **Configuration Management (Ansible)**
  - Redmine provisioning (Docker-based deployment)
  - Monitoring stack (Prometheus, Grafana, Node Exporter, cAdvisor)
  - Secrets handled via Ansible Vault
- **Observability**
  - Custom Prometheus targets
  - Grafana dashboards (`redmine_full_observability.json`)
- **Automation**
  - `setup.sh` orchestrates Terraform + Ansible
  - Inventory dynamically generated from Terraform outputs
- **CI/CD Integration**
  - `.gitlab-ci.yml` for GitLab pipelines

---

## 🛠️ Tech Stack
- **Terraform** (AWS infrastructure)
- **Ansible** (provisioning & configuration)
- **Docker Compose** (Redmine, Prometheus, Grafana)
- **AWS** (EC2, RDS Postgres, S3, EFS)
- **Prometheus + Grafana** (monitoring & observability)

---

## 🚀 Usage

### 1. Clone the repository
```bash
git clone https://gitlab.com/rayanm2acha/redmine-presentation.git
cd redmine-presentation
