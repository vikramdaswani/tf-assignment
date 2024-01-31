# create vpc
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
}

resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidr)
    vpc_id = var.aws_vpc.main.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = var.availability_zones[count.index]
}

resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnet_cidr)
    vpc_id = var.aws_vpc.main.id
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = var.availability_zones[count.index]
}

// creating internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = var.aws_vpc.main.id
    tags = {
        Name = "igw"
    }
}

//creating Natgateway
resource "aws_eip" "nat_gateway_eip" {
    count = length(var.availability_zones)
    vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
    count = length(var.availability_zones)
    allocation_id = aws_eip.nat_gateway_eip[count.index].id
    subnet_id = aws_subnet.public_subnet[count.index].id
}

// creating route tables for public subnet
resource "aws_route_table" "public_route" {
    vpc_id = var.aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
        }
        tags = {
            Name = "public_route_table ${count.index}"
        }
}

// creating route table public association
resource "aws_route_table_association" "public_subnet_association" {
    count = length(var.public_subnet_cidr)
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public_route.id
}

// creating route tables for private subnet
resource "aws_route_table" "private_route" {
    count = length(var.availability_zones)
    vpc_id = var.aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
        }
        tags = {
            Name = "private_route_table_${count.index}"
        }
}

// creating security groups
resource "aws_security_group" "demo_sg" {
    vpc_id = var.aws_vpc.main.id
    name = "webapp"
    dynamic "ingress"{
    for_each = var.allowed_ports
    content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = [var.ssh_cidr_block, var.http_cidr_block, var.https_cidr_block]
        }
    }
}

//create route 53 hosted zone and DNS CNAME for ELB
resource "aws_route53_zone" "vikram" {
    name = "vikram.com"

}
resource "aws_route53_record" "cname" {
    zone_id = aws_route53_zone.main.zone_id
    name = "vikram.com"
    type = "CNAME"
    records = [aws_elb.main.dns_name]
}