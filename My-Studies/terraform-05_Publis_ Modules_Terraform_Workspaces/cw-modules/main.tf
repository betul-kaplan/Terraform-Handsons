provider "aws" {
  region = "us-east-1"
}

module "docker_instance" {
    source = "betul-kaplan/docker-ec2-instance/aws"
    key_name = "firstkey"
    docker-instance-ports = [22,80,85,8080,8090]
}