resource "aws_vpc" "region1_vpc" {
  cidr_block = var.range_ip
  
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.project} VPC"
  }
}

resource "aws_vpc" "region2_vpc" {
  cidr_block = var.range_ip
  
  enable_dns_hostnames = true
  enable_dns_support = true
  
  provider = aws.west

  tags = {
    Name = "${var.project} VPC"
  }
}