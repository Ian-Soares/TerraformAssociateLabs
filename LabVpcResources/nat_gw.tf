resource "aws_eip" "nat_gw_eip" {
  vpc = true
  depends_on                = [aws_internet_gateway.igw_terraform]
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id

  tags = {
    Name = "nat_gw_terraform"
  }

  depends_on = [aws_internet_gateway.igw_terraform]
}