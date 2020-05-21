resource "aws_iam_role" "ec2-instance" {
  name = "role-instance-${var.AppName}"
  assume_role_policy = file("${path.module}/templates/ec2-instance-role.json")

  tags = {
    app = var.AppName
  }
}

data "aws_iam_policy_document" "ec2-policy-document" {
  // allows logging to cloudwatch
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
  // allows retrieval of artifacts from s3
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::*"
    ]
  }
}

resource "aws_iam_role_policy" "ec2-instance" {
  role = aws_iam_role.ec2-instance.id
  policy = file("${path.module}/templates/ec2-instance-policy.json")
  # policy = data.aws_iam_policy_document.ec2-policy-document.json
}

resource "aws_iam_instance_profile" "ec2-instance" {
  name = "instance-profile-${var.AppName}"
  role = aws_iam_role.ec2-instance.name
}