resource "aws_internet_gateway" "region1_main" {
  vpc_id = aws_vpc.region1_vpc.id
}

resource "aws_route_table" "region1_public" {
  vpc_id = aws_vpc.region1_vpc.id
}

resource "aws_subnet" "region1_public" {
  
  count = var.size_subnets
  cidr_block = "${cidrsubnet(aws_vpc.region1_vpc.cidr_block, local.size_subnets, count.index + 1)}"
  availability_zone = "${data.aws_availability_zones.region1_available.names[count.index]}"
  vpc_id = aws_vpc.region1_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project} public subnet ${count.index + 1}"
  }
}

resource "aws_route_table_association" "region1_public" {
  count = var.size_subnets
  subnet_id = aws_subnet.region1_public[count.index].id
  route_table_id = aws_route_table.region1_public.id
}

resource "aws_route" "region1_public" {
  route_table_id = aws_route_table.region1_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.region1_main.id
}

#region 2

resource "aws_internet_gateway" "region2_main" {
  vpc_id = aws_vpc.region2_vpc.id
  provider = aws.west
}

resource "aws_route_table" "region2_public" {
  vpc_id = aws_vpc.region2_vpc.id
  provider = aws.west
}

resource "aws_subnet" "region2_public" {
  
  count = var.size_subnets
  cidr_block = "${cidrsubnet(aws_vpc.region2_vpc.cidr_block, local.size_subnets, count.index + 1)}"
  availability_zone = data.aws_availability_zones.region2_available.names[count.index]
  provider = aws.west
  vpc_id = aws_vpc.region2_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project} public subnet ${count.index + 1}"
  }
}

resource "aws_route_table_association" "region2_public" {
  count = var.size_subnets
  provider = aws.west
  subnet_id = aws_subnet.region2_public[count.index].id
  route_table_id = aws_route_table.region2_public.id
}

resource "aws_route" "region2_public" {
  route_table_id = aws_route_table.region2_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.region2_main.id
  provider = aws.west
}