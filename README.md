# Terraform VPC and Security Group Setup Documentation

## Overview
This Terraform configuration provisions a Virtual Private Cloud (VPC) with subnets, gateways, and a default security group in AWS. The setup ensures a scalable and secure network infrastructure. It uses variables for flexibility and outputs to expose essential resource details.

## Key Components

### VPC:
Creates a VPC with a customizable CIDR block (10.0.0.0/16 by default).
DNS hostnames are enabled for resources within the VPC.

### Subnets:
#### Public Subnets:
Distributed across availability zones with public IP mapping enabled.

#### Private Subnets:
For internal resources, without public IP mapping.

#### Internet Gateway:
Provides internet access to public subnets.

#### Default Security Group:
Configurable rules to allow:
SSH access (port 22).
HTTP access (port 80).
All outbound traffic.

### File Breakdown

#### 1. main.tf
Defines the AWS resources:

Locals: Standardizes resource naming using the project_name, environment, and sg_name variables.

VPC and Subnets: Provisions a VPC, public subnets, and private subnets.

Gateways: Sets up an Internet Gateway and, optionally, a NAT Gateway for private subnets.

Security Group:
Dynamically adds SSH and HTTP ingress rules based on variables.
Allows all egress traffic by default.

#### 2. variables.tf
Customizes the setup using variables:

VPC and Subnet CIDRs: Specify IP ranges.

Ingress Rules: Control SSH and HTTP access.

Tags: Ensure consistent tagging across resources.

#### 3. outputs.tf
Exposes key details like:

VPC ID.
Public and private subnet IDs.
Security group ID.
Internet Gateway and NAT Gateway IDs.
How to Use
Initialize Terraform:


terraform init

Validate Configuration:


terraform validate

Plan: Review the changes Terraform will make:


terraform plan

Apply: Deploy the resources:


terraform apply

View Outputs: Get key resource IDs:


terraform output

#### Key Features
Flexibility: Variables let you adjust VPC size, subnet configuration, and access rules.
Security: Control ingress (SSH, HTTP) and egress dynamically.
Scalability: Subnets are distributed across availability zones for high availability.
This setup demonstrates a strong understanding of Terraform's capabilities in automating AWS infrastructure. Let me know if you need additional details!

#### Reusable VPC module

```hcl
module "vpc" {
  source                = "path/to/your/module"
  azs                   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnet_cidr    = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr   = ["10.0.3.0/24", "10.0.4.0/24"]
  db_subnet_cidr        = ["10.0.5.0/24", "10.0.6.0/24"]
  vpc_cidr              = "10.0.0.0/16"
  environment           = "dev"
  project_name          = "my-project"
  common_tags           = {
    "Owner" = "TeamA",
    "Environment" = "dev"
  }
  enable_nat            = true
  vpc_peering_enable    = false
}
```


