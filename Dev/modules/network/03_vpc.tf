resource "aws_vpc" "main" {
    cidr_block = " var.vpc_cidr_block"
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags =  merge (var.tags, {
        Name = var.vpc_name
    })
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = merge (var.tags, {
        Name = "${var.vpc_name}-igw"
    })
}

# Create public subnet with cidr defined in 03_main
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-az1"
    Tier = "public"
  })
}

# Create public subnet with cidr defined in 03_main
resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-az2"
    Tier = "public"
  })
}

# Create public route table and association
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, { Name = "${var.vpc_name}-public-rt" })
}

# Public RT: routes 0.0.0.0/0 → IGW
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Association with both public subnets.
resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public.id
}