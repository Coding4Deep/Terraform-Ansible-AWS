variable "public_instances" {
  type = map(object({
    ami           = string
    instance_type = string
  }))
  description = "Map of public instance configurations"
}

variable "public_subnet_id" {
  type        = string
  description = "ID of the public subnet for EC2 instances"
}

variable "public_sg_id" {
  type        = string
  description = "ID of the security group for public EC2 instances"
}

variable "key_name" {
  type        = string
  description = "Name of the key pair for EC2 instances"
}