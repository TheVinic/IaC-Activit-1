data "aws_availability_zones" "region1_available" {
}

data "aws_ami" "region1_linux2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-*-hvm-2.0.*-x86_64-gp2"]
  }
}

#Region 2
data "aws_availability_zones" "region2_available" {
    provider = aws.west
}

data "aws_ami" "region2_linux2" {
  most_recent = true
  owners = ["amazon"]
  provider = aws.west
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-*-hvm-2.0.*-x86_64-gp2"]
  }
}