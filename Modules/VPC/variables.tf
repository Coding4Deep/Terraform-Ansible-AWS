variable "vpc_cidr_block" {
  type = string
}
variable "public_subent_az" {
  type    = string
  default = "ap-south-1a"
}
variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_az" {
  type    = string
  default = "ap-south-1a"
}
variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/26"
}