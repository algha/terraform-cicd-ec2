
data "template_file" "codedeploy_service" {
  template = "${file("./templates/codedeploy_role.json")}"
}

data "template_file" "codedeploy_profile" {
  template = "${file("./templates/codedeploy_profile.json")}"
}

# Roles
resource "aws_iam_role" "codedeploy_service" {
  name               = "codedeploy-service-role"
  assume_role_policy = data.template_file.codedeploy_service.rendered
}

resource "aws_iam_role" "codedeploy_profile" {
  name               = "codedeploy-profile"
  assume_role_policy = data.template_file.codedeploy_profile.rendered
}

# Policy attachments
resource "aws_iam_role_policy_attachment" "codedeploy_service" {
  role       = aws_iam_role.codedeploy_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

resource "aws_iam_role_policy_attachment" "instance_profile_codedeploy" {
  role       = aws_iam_role.codedeploy_profile.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}


# instance profile
resource "aws_iam_instance_profile" "codedeploy-profile" {
  name = "codedeploy-profile"
  role = aws_iam_role.codedeploy_profile.name
}