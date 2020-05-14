
# Define AWS as our provider
provider "aws" {
  region = var.aws_region
}

# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "DevOpsCourse"
  public_key = file(var.key_path)
}

# Module VPC
module "vpc" {
  source = "./vpc" 
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

resource "aws_instance" "wb" {
   ami  = var.ami
   instance_type = "t1.micro"
   subnet_id = module.vpc.public-subnet
   vpc_security_group_ids = [module.vpc.aws_security_group_web]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = file("install.sh")

  tags = {
    Name = "webserver"
  }
}

# Define database inside the private subnet
resource "aws_instance" "db" {
   ami  = var.ami
   instance_type = "t1.micro"
   key_name = aws_key_pair.default.id
   subnet_id = module.vpc.private-subnet
   vpc_security_group_ids = [module.vpc.aws_security_group_db]

   source_dest_check = false

  tags = {
    Name = "database"
  }
}


