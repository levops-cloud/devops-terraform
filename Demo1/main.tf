# Create a new instance of Amazon Linux AMI on an
# t2.micro node with an AWS Tag naming it "GeekWeek2019"

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "ami-0f2176987ee50226e"
  instance_type = "t2.micro"

  tags = {
    Name = "DevOpsCourse"
  }
}