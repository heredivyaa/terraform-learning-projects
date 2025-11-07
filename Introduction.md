# Terraform Learning Projects – Divya Sharma

Welcome to my Terraform learning repository.  
This repo contains all the hands-on projects I create while learning Terraform — from basic setups to advanced infrastructure automation on AWS.

---

## About Terraform

Terraform is an open-source Infrastructure as Code (IaC) tool by HashiCorp that allows you to define and provision cloud infrastructure using declarative configuration files.  
It supports multiple providers such as AWS, Azure, and Google Cloud.

### Key Concepts:
- **Provider** → Defines which platform (e.g., AWS) Terraform will interact with.  
- **Resource** → The infrastructure object (like EC2 instance, VPC, or S3 bucket) created using Terraform.  
- **State File (`.tfstate`)** → Tracks resources Terraform manages.  
- **Plan → Apply → Destroy** → The main Terraform workflow.

---

## Project 1: EC2 Instance Creation

**Folder:** `ec2_instance_creation/`  
**Goal:** Create and launch an EC2 instance on AWS using Terraform.

### Files Overview:
| File | Description |
|------|--------------|
| `main.tf` | Defines provider and EC2 instance configuration |
| `terraform.tfstate` | Tracks the instance state (ignored in GitHub) |
| `.terraform/` | Contains provider binaries (ignored in GitHub) |

### Commands Used:
```bash
terraform init       # Initialize Terraform and download provider plugins
terraform plan       # Preview the changes to be made
terraform apply      # Create resources on AWS
terraform destroy    # Delete the resources created

Output:

An EC2 instance of type t3.micro launched successfully in the ap-south-1 region.

Learning Goals

Understand Infrastructure as Code (IaC) concepts

Get hands-on with AWS automation

Learn best practices for modular and reusable Terraform configurations
