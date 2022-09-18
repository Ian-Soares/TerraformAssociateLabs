
resource "aws_subnet" "public_subnet_a" {
  vpc_id     = aws_vpc.vpc_terraform.id
  cidr_block = "192.168.1.0/24"

  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "public_subnet_a"
    Owner       = var.owner
    Department  = var.department
    Environment = var.environment
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id     = aws_vpc.vpc_terraform.id
  cidr_block = "192.168.2.0/24"

  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "public_subnet_b"
    Owner       = var.owner
    Department  = var.department
    Environment = var.environment
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.vpc_terraform.id
  cidr_block = "192.168.3.0/24"

  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "private_subnet_a"
    Owner       = var.owner
    Department  = var.department
    Environment = var.environment
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id     = aws_vpc.vpc_terraform.id
  cidr_block = "192.168.4.0/24"

  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "private_subnet_b"
    Owner       = var.owner
    Department  = var.department
    Environment = var.environment
  }
}
