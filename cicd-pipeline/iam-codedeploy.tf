
data "template_file" "codedeploy-role" {
  template = file("${path.module}/templates/codedeploy_role.json")
}

data "template_file" "codedeploy-policy" {
  template = file("${path.module}/templates/codedeploy_policy.json")
}

resource "aws_iam_role" "codedeploy" {
  name               = "role-codedeploy-${var.AppName}"
  assume_role_policy = data.template_file.codedeploy-role.rendered
}

resource "aws_iam_role_policy" "codedeploy" {
  role   = aws_iam_role.codedeploy.id
  policy = data.template_file.codedeploy-policy.rendered
}