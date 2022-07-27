provider "aws" {
  region = "us-east-1"
}

module "docker_instance" {
    source = "betul-kaplan/docker-instance/aws"
    key_name = "firstkey"
    docker-instance-ports = [ 22, 80, 8080 ]
    num_of_instance = 2

}