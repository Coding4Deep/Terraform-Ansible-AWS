resource "aws_instance" "public_ec2" {
  for_each = var.public_instances

  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.public_sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = each.key
    Role = each.key
  }
}





