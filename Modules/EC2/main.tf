module "key_pair" {
  source   = "./keypair"
  key_name = var.key_name
}

module "public_instances" {
  source           = "./publicEC2"
  public_instances = var.public_instances
  public_subnet_id = var.public_subnet_id
  public_sg_id     = var.public_sg_id
  key_name         = var.key_name
}

module "private_instances" {
  source            = "./privateEC2"
  private_instances = var.private_instances
  private_subnet_id = var.private_subnet_id
  private_sg_id     = var.private_sg_id
  key_name          = var.key_name
}