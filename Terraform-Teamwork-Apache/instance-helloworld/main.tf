terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "linux-2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220606.1-x86_64-gp2"]

  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}
data "template_file" "userdata" {
  template = file("userdata.sh")

  }

resource "aws_instance" "web" {
  ami           = data.aws_ami.linux-2.id
  instance_type = var.ec2_type
  count         = 2
  key_name      = "firstkey"
  user_data     = data.template_file.userdata.rendered
  tags = {
    Name = element(var.instance-tags, count.index)
  }
  security_groups = ["apache-sg"]

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> public_ips.txt"
  }
}

resource "aws_security_group" "apache-sg" {
  name        = "apache-sg"
  description = "Allow TLS inbound traffic"


  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow_tls"
  }
}