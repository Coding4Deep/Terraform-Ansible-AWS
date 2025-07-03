terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0"
    }
  }
  required_version = ">= 0.12"

  backend "s3" {
    bucket  = "terraform-ansible-project-bucket"
    key     = "env/dev/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}

provider "vault" {
  address         = "http://3.83.239.200:8200"
  token           = var.vault_token
  skip_tls_verify = true
}


data "vault_generic_secret" "aws_creds" {
  path = "aws-creds/myapp"
}

provider "aws" {
  access_key = data.vault_generic_secret.aws_creds.data["access_key"]
  secret_key = data.vault_generic_secret.aws_creds.data["secret_key"]
  region     = var.aws_region
}   



module "vpc" {
  source         = "./Modules/VPC"
  vpc_cidr_block = var.vpc_cidr_block
}

module "SecurityGroup" {
  source = "./Modules/SecurityGroup"
  vpc_id = module.vpc.vpc_id
}


module "EC2" {
  source           = "./Modules/EC2"
  key_name         = var.key_name
  public_subnet_id = module.vpc.public_subnet_id
  public_sg_id     = module.SecurityGroup.public_sg_id

  private_subnet_id = module.vpc.private_subnet_id
  private_sg_id     = module.SecurityGroup.private_sg_id
}



