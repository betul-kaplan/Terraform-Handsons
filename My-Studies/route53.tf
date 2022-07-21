resource "aws_route53_record" "www" {
  zone_id = "Z04731291FUR8EFBQ8LZV"
  name    = "test.betuldurankaplan.com"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.tf-ec2.public_ip]
}