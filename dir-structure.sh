#!/bin/bash

# Top-level files
touch main.tf variables.tf outputs.tf terraform.tfvars

# Modules base directory
mkdir -p Modules

# EC2 module and submodules
mkdir -p Modules/EC2
mkdir -p Modules/EC2/privateEC2
mkdir -p Modules/EC2/keypair
mkdir -p Modules/EC2/publicEC2
touch Modules/EC2/main.tf
touch Modules/EC2/variables.tf
touch Modules/EC2/outputs.tf
touch Modules/EC2/keypair/main.tf      Modules/EC2/keypair/variables.tf     Modules/EC2/keypair/outputs.tf
touch Modules/EC2/privateEC2/main.tf   Modules/EC2/privateEC2/variables.tf  Modules/EC2/privateEC2/outputs.tf
touch Modules/EC2/publicEC2/main.tf    Modules/EC2/publicEC2/variables.tf   Modules/EC2/publicEC2/outputs.tf 

# SecurityGroup module
mkdir -p Modules/SecurityGroup
touch Modules/SecurityGroup/main.tf Modules/SecurityGroup/variables.tf Modules/SecurityGroup/locals.tf

# VPC module and submodules
mkdir -p Modules/VPC
mkdir -p Modules/VPC/privateSubnet
mkdir -p Modules/VPC/publicSubnet
touch Modules/VPC/main.tf                Modules/VPC/variables.tf               Modules/VPC/outputs.tf
touch Modules/VPC/privateSubnet/main.tf  Modules/VPC/privateSubnet/variables.tf Modules/VPC/privateSubnet/outputs.tf
touch Modules/VPC/publicSubnet/main.tf   Modules/VPC/publicSubnet/variables.tf  Modules/VPC/publicSubnet/outputs.tf

echo "✅ Terraform-AWS directory structure created successfully."
