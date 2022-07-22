provider "aws" {
  region  = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}

# variable "ec2_name" {
#   default = "oliver-ec2"
# }

# variable "ec2_type" {
#   default = "t2.micro"
# }

# variable "ec2_ami" {
#   default = "ami-0742b4e673072066f"
# }

locals {
  mytag = "betul11-local-name"
}

resource "aws_instance" "tf-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name      = "firstkey"
  tags = {
    Name = "${local.mytag}-come from locals"
  }
}

#variable "s3_bucket_name" {
#  default = "adunacasss-s3-bucket-variable-addwhateveryouwant"
#}

resource "aws_s3_bucket" "tf-s3" {
  bucket = "${var.s3_bucket_name}-${count.index}"
  count = var.num_of_buckets
}

output "tf-example-public_ip" {
  value = aws_instance.tf-ec2.public_ip
}

output "tf_example_private_ip" {
  value = aws_instance.tf-ec2.private_ip
}

output "tf-example-s3" {
  value = aws_s3_bucket.tf-s3[*]
}