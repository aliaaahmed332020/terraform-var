# terraform-var
the main file:
provider "aws" {
    profile = "default"
    region = var.availability_zone_names
}

resource "aws_default_vpc" "main" {

  tags = {
    Name = "main"
  }
}
resource "aws_security_group" "aliaa-sec-group" {
  name        = "aliaa-sec-group"
  description = "Allow tls inbound traffic"
  vpc_id      = aws_default_vpc.main.id

  ingress {
    description      = "inbound rules from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_default_vpc.main.cidr_block]


  }
  ingress {
    description      = "inbound rules from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_default_vpc.main.cidr_block]

  }
  ingress {
    description      = "inbound rules from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_default_vpc.main.cidr_block]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws_security_group"
    instance_name = "aws_instance"
  }
}

resource "aws_instance" "ec2-instance" {
    ami = var.image_id
    instance_type = "t2.micro"
    security_groups = [aws_security_group.aliaa-sec-group.name]
    key_name = var.keypair
}


the variables declaration:

variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
}
variable "availability_zone_names" {
  type    = string
  default = "us-west-1a"
}
variable "keypair" {
  type        = string
  description = "The aliaa keypair of the machine server."
}

assigning the values:

image_id = "ami-0960de83329d12f2f"
availability_zone_names = "eu-west-3"
keypair = "Aliaa-key-pair"

