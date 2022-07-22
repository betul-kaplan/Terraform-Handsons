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
  mytag = "oliver-local-name"
}

resource "aws_instance" "tf-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name      = "firstkey"    # write your pem file without .pem extension>
  tags = {
    Name = "${local.mytag}-come from locals"
  }
}

# variable "s3_bucket_name" {
#   default = "bkpln-s3-bucket-variable"
# }

resource "aws_s3_bucket" "tf-s3" {
  bucket = "${var.s3_bucket_name}-${count.index}"
  count = var.num_of_buckets
}

output "tf_example_public_ip" {
  value = aws_instance.tf-ec2.id
}

# output "tf_example_s3_meta" {
#   value = aws_s3_bucket.tf-s3.region
# }

output "tf_example_private_ip" {
  value = aws_instance.tf-ec2.private_ip
}