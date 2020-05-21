resource "aws_codedeploy_app" "main" {
  name = "codedeploy-${var.AppName}"
}

resource "aws_codedeploy_deployment_group" "main" {
  app_name              = aws_codedeploy_app.main.name
  deployment_group_name = "deployment-group-${var.AppName}"
  service_role_arn      = aws_iam_role.codedeploy.arn

  deployment_config_name = "CodeDeployDefault.OneAtATime"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "app"
      type  = "KEY_AND_VALUE"
      value = var.AppName
    }
  }
  
  auto_rollback_configuration {
    enabled = true
    events = [
      "DEPLOYMENT_FAILURE"
    ]
  }
}