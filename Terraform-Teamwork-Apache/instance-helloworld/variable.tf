variable "ec2_type" {
  default = "t2.micro"
}

variable "instance-tags" {
  type    = list(string)
  default = ["Terraform-First-Instance", "Terraform-Second-Instance"]
}