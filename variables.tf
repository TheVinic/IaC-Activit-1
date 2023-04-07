variable "region1" {
  description = "region 1"
  default = "us-east-1"
}

variable "region2" {
  description = "region 2"
  default = "us-west-2"
}

variable "project" {
  description = "Project name"
  default = "Activity1"
}

variable "range_ip" {
  description = "Range IP"
  default = "172.26.0.0/16"
}

variable "size_subnets" {
  description = "amount of subnets"
  default = 3
}

variable "quantity_instances" {
  description = "number of instances"
  default = 2
}

variable "key_instance" {
  description = "instance key"
  default = "terraform"
}