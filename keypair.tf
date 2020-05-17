resource "aws_key_pair" "cicd" {
  key_name    = "cicd"
  public_key  = file(var.PATH_PUBLIC_KEY)
}