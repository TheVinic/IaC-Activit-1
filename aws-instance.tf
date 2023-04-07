resource "aws_instance" "region1_main" {
  count = var.quantity_instances
  ami = data.aws_ami.region1_linux2.image_id
  instance_type = "t3.micro"
  key_name = var.key_instance
  subnet_id = "${aws_subnet.region1_public.0.id}"
  vpc_security_group_ids = [aws_security_group.region1_main["instances"].id]
  tags = {
    Name = "${var.project} ${count.index}"
  }
}

#Region 2
resource "aws_instance" "region2_main" {
  count = var.quantity_instances
  provider = aws.west
  ami = data.aws_ami.region2_linux2.image_id
  instance_type = "t3.micro"
  key_name = var.key_instance
  subnet_id = "${aws_subnet.region2_public.0.id}"
  vpc_security_group_ids = [aws_security_group.region2_main["instances"].id]
  tags = {
    Name = "${var.project} ${count.index}"
  }
}