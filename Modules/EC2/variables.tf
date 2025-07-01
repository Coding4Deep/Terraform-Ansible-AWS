variable "key_name" {
  description = "The name of the key pair to create or use."
  type        = string
}


variable "public_instances" {
  description = "Map of public instance configurations"
  type = map(object({
    ami           = string
    instance_type = string
  }))
  default = {
    "jenkins" = {
      ami           = "ami-0f918f7e67a3323f0"
      instance_type = "t2.micro"
    },
    "tomcat" = {
      ami           = "ami-0f918f7e67a3323f0"
      instance_type = "t2.micro"
    },
    "nexus" = {
      ami           = "ami-0f918f7e67a3323f0"
      instance_type = "t2.micro"
    },
    "sonarqube" = {
      ami           = "ami-0f918f7e67a3323f0"
      instance_type = "t2.medium"
    }
  }
}

variable "public_subnet_id" {
  type = string
}

variable "public_sg_id" {
  type = string
}





variable "private_instances" {
  type = map(object({
    ami           = string
    instance_type = string
  }))
  description = "Map of private instance configurations"
  default = {
    "backend" = {
      ami           = "ami-0f918f7e67a3323f0"
      instance_type = "t2.medium"
    }
  }
}

variable "private_subnet_id" {
  type        = string
  description = "ID of the public subnet for EC2 instances"
}

variable "private_sg_id" {
  type        = string
  description = "ID of the security group for public EC2 instances"
}

