output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}
output "vpc_id" {
  value = module.vpc.vpc_id
}



output "pem_file_path" {
  value = module.EC2.pem_file_path
}

output "pem_file_name" {
  value = module.EC2.pem_file_name
}