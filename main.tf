terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0"
    }
  }
  required_version = ">= 0.12"
}

provider "vault" {
  address         = "http://127.0.0.1:8200"
  token           = var.vault_token
  skip_tls_verify = true
}

data "vault_kv_secret_v2" "awscreds" {
  mount = "secret"
  name  = "aws"
}

provider "aws" {
  access_key = data.vault_kv_secret_v2.awscreds.data["access_key"]
  secret_key = data.vault_kv_secret_v2.awscreds.data["secret_key"]
  region     = var.aws_region
}

module "vpc" {
  source         = "./Modules/VPC"
  vpc_cidr_block = var.vpc_cidr_block
}
