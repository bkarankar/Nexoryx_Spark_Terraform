
# Nexoryx_Spark_Terraform

Production-ready Terraform automation for deploying an Apache Spark cluster on AWS with:

- 1 Spark Master
- 20 Spark Workers
- Ubuntu 24.04
- Docker-based Spark deployment
- Security Groups
- Auto provisioning
- Scalable infrastructure

---

# Architecture

AWS VPC
   |
   +-- Spark Master EC2
   |
   +-- 20 Spark Worker EC2 Instances

---

# Features

- Terraform-based infrastructure automation
- Spark Master auto configuration
- Spark Worker auto join
- Security groups
- SSH access
- Ubuntu 24.04
- Docker installation
- Apache Spark cluster deployment

---

# Requirements

- AWS Account
- Terraform >= 1.5
- Existing AWS key pair
- AWS CLI configured

---

# Usage

## Initialize

```bash
terraform init
```

## Plan

```bash
terraform plan
```

## Deploy

```bash
terraform apply -auto-approve
```

## Destroy

```bash
terraform destroy -auto-approve
```

---

# Outputs

- Spark Master Public IP
- Spark Master URL
- Worker Instance IDs

---

# Spark Web UI

```text
http://SPARK_MASTER_IP:8080
```

---

# License

MIT License
