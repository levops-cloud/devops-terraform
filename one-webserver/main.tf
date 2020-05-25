terraform {
  required_version = ">= 0.12, < 0.13"
}

terraform {
  backend "s3" {
    bucket = "terraform-bucket-972159745121"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource "aws_instance" "example" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"

  tags = {
    Name = "terraform-default"
  }
}