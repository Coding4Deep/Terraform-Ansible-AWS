output "public_sg_id" {
  value = aws_security_group.PublicEC2SecurityGroup.id
}

output "private_sg_id" {
  value = aws_security_group.PrivateEC2SecurityGroup.id
}