output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_sg_id" {
  value = module.SecurityGroup.public_sg_id
}

output "private_sg_id" {
  value = module.SecurityGroup.private_sg_id
}

output "pem_file_path" {
  value = module.EC2.pem_file_path
}

output "pem_file_name" {
  value = module.EC2.pem_file_name
}

output "private_instances_private_ips" {
  value = module.EC2.private_instances_private_ips
}

output "public_instances_public_ips" {
  value = module.EC2.public_instances_public_ips
}

