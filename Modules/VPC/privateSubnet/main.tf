resource "aws_subnet" "private_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_subnet_az
  tags = {
    Name = "terraform_private_subnet"
  }
}

resource "aws_eip" "private_eip" {
  tags = {
    Name = "Terraform_Private_NAT_Gateway_EIP"
  }
}

resource "aws_nat_gateway" "private_nat_gateway" {
  allocation_id = aws_eip.private_eip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "terraform _nat"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private_nat_gateway.id
  }

  tags = {
    Name = "terraform_private_rt"
  }
}
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}