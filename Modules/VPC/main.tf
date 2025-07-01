resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "terraform_vpc"
  }
}

module "public_subnet" {
  source             = "./publicSubnet"
  vpc_id             = aws_vpc.vpc.id
  public_subnet_az   = var.public_subent_az
  public_subnet_cidr = var.public_subnet_cidr
}

module "private_subnet" {
  source              = "./privateSubnet"
  vpc_id              = aws_vpc.vpc.id
  private_subnet_az   = var.private_subnet_az
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_id    = module.public_subnet.public_subnet_id
}