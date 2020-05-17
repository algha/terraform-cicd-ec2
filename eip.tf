resource "aws_eip" "cicd-eip" {
  instance = aws_instance.cicdtest.id
  vpc      = true
}