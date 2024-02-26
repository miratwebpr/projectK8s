resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "main"
    }
}

resource "aws_subnet" "public" {
    count = 3

    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 4, ${count.index + 1})
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet-${count.index + 1}"
    }
}

resource "aws_subnet" "private" {
    count = 3

    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 8, count.index)
    availability_zone = var.availability_zones[count.index]

    tags = {
        Name = "private_subnet-${count.index + 1}"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
}

resource "aws_route" "public" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
}

resource "aws_route" "private" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "public" {
    count = 3
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
    count = 3
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "main" {
    allocation_id = aws_eip.main.id
    subnet_id = aws_subnet.public[0].id
}

resource "aws_eip" "main" {
    
}