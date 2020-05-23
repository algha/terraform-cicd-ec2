data "template_file" "codebuild-role" {
  template = file("${path.module}/templates/codebuild_role.json")
}

data "template_file" "codebuild-policy" {
  template = file("${path.module}/templates/codebuild_policy.json")
}

resource "aws_iam_role" "codebuild" {
  name               = "role-codebuild-${var.AppName}"
  assume_role_policy = data.template_file.codebuild-role.rendered
}

resource "aws_iam_role_policy" "codebuild" {
  name   = "codebuild-policy-${var.AppName}"
  role   = aws_iam_role.codebuild.id
  policy = data.template_file.codebuild-policy.rendered
}