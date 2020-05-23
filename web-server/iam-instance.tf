resource "aws_iam_role" "ec2-instance" {
  name               = "role-instance-${var.AppName}"
  assume_role_policy = file("${path.module}/templates/ec2-instance-role.json")

  tags = {
    App = var.AppName
  }
}


resource "aws_iam_role_policy" "ec2-instance" {
  role   = aws_iam_role.ec2-instance.id
  policy = file("${path.module}/templates/ec2-instance-policy.json")
}

resource "aws_iam_instance_profile" "ec2-instance" {
  name = "instance-profile-${var.AppName}"
  role = aws_iam_role.ec2-instance.name
}