resource "aws_key_pair" "main" {
  key_name   = var.AppName
  public_key = file("${path.module}/keys/secret.pub")

  tags = {
    Name = "key-pair-${var.AppName}"
    App  = var.AppName
  }
}