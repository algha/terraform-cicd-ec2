resource "aws_codebuild_project" "main" {
  name = "codebuild-${var.AppName}-${var.SourceBranch}"
  description = var.AppName

  # in minutes
  build_timeout = "10"
  service_role = aws_iam_role.codebuild.arn

  source {
    type = "CODEPIPELINE"
  }

  source_version = var.SourceBranch

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:4.0"
    type = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  tags = {
    app = var.AppName
  }
}