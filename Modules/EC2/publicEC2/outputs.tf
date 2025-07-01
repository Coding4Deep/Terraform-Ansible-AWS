output "public_instances_public_ips" {
  value = {
    for name, instance in aws_instance.public_ec2 :
    name => instance.public_ip
  }
}
