# Create Management VPC
resource "aws_vpc" "this" {
  cidr_block = "10.255.0.0/23"

  tags = {
    Name = var.vpc_name
  }
}

# Create Public Subnet 1
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 1, 0)

  tags = {
    Name = "${var.vpc_name}-public-subnet1"
  }
}

# Create Public Subnet 2 | for Aviatrix Controller HA
resource "aws_subnet" "public_subnet2" {
  count = var.create_public_subnet2 ? 1 : 0
  
  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 1, 1)

  tags = {
    Name = "${var.vpc_name}-public-subnet2"
  }
}

# Create AWS IGW
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.igw_name
  }
}

# Create Default Route to AWS IGW
resource "aws_default_route_table" "this" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "default-route-to-igw"
  }
}