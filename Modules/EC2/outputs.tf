output "pem_file_path" {
  value = module.key_pair.pem_file_path
}

output "pem_file_name" {
  value = module.key_pair.pem_file_name
}

output "private_instances_private_ips" {
  value = module.private_instances.private_instances_private_ips
}

output "public_instances_public_ips" {
  value = module.public_instances.public_instances_public_ips
}