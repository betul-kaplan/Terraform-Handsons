resource "aws_iam_user" "myfirst-user" {
  name = "betul"

  tags = {
    tag-key = "DevOpsBetul"
    enviroment = "Dev"
  }
}