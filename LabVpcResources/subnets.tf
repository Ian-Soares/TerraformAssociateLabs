resource "aws_subnet" "public_subnet_a" {
  vpc_id     = aws_vpc.vpc_terraform.id
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "publicSubnetA"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id     = aws_vpc.vpc_terraform.id
  cidr_block = "192.168.2.0/24"

  tags = {
    Name = "publicSubnetB"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.vpc_terraform.id
  cidr_block = "192.168.3.0/24"

  tags = {
    Name = "privateSubnetA"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id     = aws_vpc.vpc_terraform.id
  cidr_block = "192.168.4.0/24"

  tags = {
    Name = "privateSubnetB"
  }
}