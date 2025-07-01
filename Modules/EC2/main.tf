module "key_pair" {
  source   = "./keypair"
  key_name = var.key_name
}