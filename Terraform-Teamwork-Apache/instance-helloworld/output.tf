output "instances-public-ip" {
  value = aws_instance.web[*].public_ip
}