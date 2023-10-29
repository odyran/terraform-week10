resource "aws_vpc" "vpc1" {
  cidr_block       = "172.120.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Terraform-vpc"
    env  = "Dev"
  }
}

resource "aws_subnet" "public_subnet1" {
  availability_zone       = "us-east-1a"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "172.120.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-subnet1-vpc"
    env  = "Dev"
  }
}

resource "aws_subnet" "public_subnet2" {
  availability_zone       = "us-east-1b"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "172.120.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-subnet2-vpc"
    env  = "Dev"
  }
}

## Private Subnet

resource "aws_subnet" "private_subnet1" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "172.120.3.0/24"

  tags = {
    Name = "Private-subnet1-vpc"
    env  = "Dev"
  }
}

resource "aws_subnet" "private_subnet2" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "172.120.4.0/24"

  tags = {
    Name = "private-subnet2-vpc"
    env  = "Dev"
  }
}


## Gateway
resource "aws_internet_gateway" "gtw1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "IGW"
  }
}

## Route Table
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gtw1.id
  }
}

## Route association
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_eip" "ei" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.ei.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "gw NAT"
  }
}