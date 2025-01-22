### Locals
locals {
  name = "${var.environment}-${var.project_name}"
}

### VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
  )
}

### IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
  )

}

### Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${local.name}-public-${split("-", var.azs[count.index])[2]}"
    },
    var.common_tags
  )
}

### Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(
    {
      Name = "${local.name}-private-${split("-", var.azs[count.index])[2]}"
    },
    var.common_tags
  )
}

### Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      Name = "${local.name}-public"
    },
    var.common_tags
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      Name = "${local.name}-private"
    },
    var.common_tags
  )
}

### Route Table Associations
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

### NAT Gateway
resource "aws_eip" "eip" {
  count  = var.enable_nat ? 1 : 0
  domain = "vpc"
  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
  )
}

resource "aws_nat_gateway" "example" {
  count         = var.enable_nat ? 1 : 0
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
  )
  depends_on = [aws_internet_gateway.gw]
}