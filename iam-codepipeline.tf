resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "uyghur---test-bucket"
  acl    = "private"
}

data "template_file" "codedepipeline_service" {
  template = "${file("./templates/codepipeline_role.json")}"
}

data "template_file" "codedepipeline_policy" {
  template = "${file("./templates/codepipeline_role.json")}"
  vars = {
    arn = aws_s3_bucket.codepipeline_bucket.arn
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name = "test-role"

  assume_role_policy = data.template_file.codedepipeline_service.rendered
}



data "aws_iam_policy_document" "demo-codepipeline-role-policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      "arn:aws:iam::*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:Encrypt",
      "kms:ReEncrypt*",
      "kms:Decrypt",
    ]
    resources = [
      aws_kms_key.demo-artifacts.arn,
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "codedeploy:*",
      "ec2:*",
      "s3:*",
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline_policy"
  role = aws_iam_role.codepipeline_role.id

  policy = data.aws_iam_policy_document.demo-codepipeline-role-policy.json

}
