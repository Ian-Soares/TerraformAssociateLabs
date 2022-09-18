resource "aws_vpc" "vpc_terraform" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name        = var.vpc_name
    Owner       = var.owner
    Department  = var.department
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw_terraform" {
  vpc_id = aws_vpc.vpc_terraform.id

  tags = {
    Name        = var.igw_name
    Owner       = var.owner
    Department  = var.department
    Environment = var.environment
  }
}

resource "aws_route_table" "public_rt_table" {
  vpc_id = aws_vpc.vpc_terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_terraform.id
  }

  tags = {
    Name        = "public_rt_table"
    Owner       = var.owner
    Department  = var.department
    Environment = var.environment
  }
}

resource "aws_route_table" "private_rt_table" {
  vpc_id = aws_vpc.vpc_terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name        = "private_rt_table"
    Owner       = var.owner
    Department  = var.department
    Environment = var.environment
  }
}

resource "aws_route_table_association" "assoc_public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt_table.id
}

resource "aws_route_table_association" "assoc_public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt_table.id
}

resource "aws_route_table_association" "assoc_private_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_rt_table.id
}

resource "aws_route_table_association" "assoc_private_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rt_table.id
}

resource "aws_eip" "nat_gw_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw_terraform]
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id

  tags = {
    Name        = var.nat_gw_name
    Owner       = var.owner
    Department  = var.department
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.igw_terraform]
}