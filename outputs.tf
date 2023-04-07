output "region1_vpc_id" {
  value = aws_vpc.region1_vpc.id
}

output "region2_vpc_id" {
  value = aws_vpc.region2_vpc.id
}

output "region1_instance_ips" {
  value = aws_instance.region1_main.*.public_ip
}

output "region1_database_url" {
  value = aws_db_instance.region1_main.address
}

output "region1_elb_url" {
  value = aws_lb.region1_lb_main.dns_name
}

output "region1_vpc" {
  value = aws_vpc.region1_vpc.id
}

output "region2_instance_ips" {
  value = aws_instance.region2_main.*.public_ip
}

output "region2_database_url" {
  value = aws_db_instance.region2_main.address
}

output "region2_elb_url" {
  value = aws_lb.region2_lb_main.dns_name
}

output "region2_vpc" {
  value = aws_vpc.region2_vpc.id
}