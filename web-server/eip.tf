resource "aws_eip" "main" {
  instance = aws_instance.main.id
  vpc      = true
}