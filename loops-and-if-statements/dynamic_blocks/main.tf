provider "aws" {
  region  = "us-east-2"
  version = "~> v3.21"
}


## Nested Configuration Block
resource "aws_security_group" "simple" {
  name        = "demo-simple"
  description = "demo-simple"

  ingress {
    description = "description 0"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "description 1"
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "simple" {
  value = aws_security_group.simple
}

## Dynamic Nested Block 
#
locals {
  ports = [80, 81]
}

resource "aws_security_group" "dynamic" {
  name        = "demo-dynamic"
  description = "demo-dynamic"

  dynamic "ingress" {
    for_each = local.ports
    content {
      description = "description ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
output "dynamic" {
  value = aws_security_group.dynamic
}

## Useful Dynamic Block with Attrs List
#
locals {
  rules = [{
    description = "description 0",
    port        = 80,
    cidr_blocks = ["0.0.0.0/0"],
    }, {
    description = "description 1",
    port        = 81,
    cidr_blocks = ["10.0.0.0/16"],
  }]
}

resource "aws_security_group" "attrs" {
  name        = "demo-attrs"
  description = "demo-attrs"

  dynamic "ingress" {
    for_each = local.rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
output "attrs" {
  value = aws_security_group.attrs
}

## Useful Dynamic Block with Attrs Map
#
locals {
  map = {
    "description 0" = {
      port        = 80,
      cidr_blocks = ["0.0.0.0/0"],
    }
    "description 1" = {
      port        = 81,
      cidr_blocks = ["10.0.0.0/16"],
    }
  }
}
resource "aws_security_group" "map" {
  name        = "demo-map"
  description = "demo-map"

  dynamic "ingress" {
    for_each = local.map
    content {
      description = ingress.key # IE: "description 0"
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
output "map" {
  value = aws_security_group.map
}
