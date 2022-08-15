terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "vpc_terraform" {
    cidr_block = var.vpc_cidr_block

    tags = {
      Name = "vpc_terraform"
      Owner = "ian.soares"
      Department = var.Department
    }
}

resource "aws_internet_gateway" "igw_terraform" {
  vpc_id = aws_vpc.vpc_terraform.id

  tags = {
    Name = "igw-terraform"
    Owner = "ian.soares"
    Department = var.Department
  }
}

resource "aws_route_table" "public_rt_table" {
  vpc_id = aws_vpc.vpc_terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_terraform.id
  }

  tags = {
    Name = "public_rt_table"
    Owner = "ian.soares"
    Department = var.Department
  }
}

resource "aws_route_table" "private_rt_table" {
  vpc_id = aws_vpc.vpc_terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private_rt_table"
    Owner = "ian.soares"
    Department = var.Department
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
