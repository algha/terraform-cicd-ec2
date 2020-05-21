
data "template_file" "codepipeline-role" {
  template = file("${path.module}/templates/codepipeline_role.json")
}

data "template_file" "codepipeline-policy" {
  template = file("${path.module}/templates/codepipeline_policy.json")
}

resource "aws_iam_role" "codepipeline" {
  name = "role-codepipeline-${var.AppName}"
  assume_role_policy = data.template_file.codepipeline-role.rendered
}

resource "aws_iam_role_policy" "codepipeline" {
  name = "codepipeline-policy-${var.AppName}"
  role = aws_iam_role.codepipeline.id
  policy = data.template_file.codepipeline-policy.rendered
}
