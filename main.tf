resource "aws_vpc" "telus" {
  cidr_block = "10.0.0.0/16"
  tags       = var.tags_all
}

resource "aws_subnet" "telus_public_subnet1" {
  vpc_id                  = aws_vpc.telus.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ca-central-1a"
  tags                    = var.tags_all
}

resource "aws_subnet" "telus_public_subnet2" {
  vpc_id                  = aws_vpc.telus.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ca-central-1b"
  tags                    = var.tags_all
}

resource "aws_subnet" "telus_private_subnet" {
  vpc_id            = aws_vpc.telus.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ca-central-1a"
  tags              = var.tags_all
}

resource "aws_internet_gateway" "telus_igw" {
  vpc_id = aws_vpc.telus.id
  tags   = var.tags_all
}

resource "aws_route_table" "telus_public_rt" {
  vpc_id = aws_vpc.telus.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.telus_igw.id
  }
  tags = var.tags_all
}

resource "aws_route_table_association" "telus_public_rt1_assoc" {
  subnet_id      = aws_subnet.telus_public_subnet1.id
  route_table_id = aws_route_table.telus_public_rt.id
}

resource "aws_route_table_association" "telus_public_rt2_assoc" {
  subnet_id      = aws_subnet.telus_public_subnet2.id
  route_table_id = aws_route_table.telus_public_rt.id
}

resource "aws_route_table" "telus_private_rt" {
  vpc_id = aws_vpc.telus.id
  tags   = var.tags_all
}

resource "aws_route_table_association" "private_rt_assoc" {
  subnet_id      = aws_subnet.telus_private_subnet.id
  route_table_id = aws_route_table.telus_private_rt.id
}

resource "aws_eip" "telus_nat_eip1" {
  domain = "vpc"
  tags   = var.tags_all
}

resource "aws_eip" "telus_nat_eip2" {
  domain = "vpc"
  tags   = var.tags_all
}

resource "aws_nat_gateway" "telus_nat_gw1" {
  allocation_id = aws_eip.telus_nat_eip1.id
  subnet_id     = aws_subnet.telus_public_subnet1.id
  tags          = var.tags_all
}

resource "aws_nat_gateway" "telus_nat_gw2" {
  allocation_id = aws_eip.telus_nat_eip2.id
  subnet_id     = aws_subnet.telus_public_subnet2.id
  tags          = var.tags_all
}

resource "aws_route" "telus_private_rt_nat" {
  route_table_id         = aws_route_table.telus_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.telus_nat_gw1.id
}