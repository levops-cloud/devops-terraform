variable "vpc_cidr" {
  description = "CIDR for the VPC"
#   default = "10.0.0.0/16"
  type = "string"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
#  default = "10.0.1.0/24"
  type = "string"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
#   default = "10.0.2.0/24"
  type = "string"
}