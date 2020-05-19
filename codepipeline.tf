resource "aws_codepipeline" "codepipeline" {
  name     = "terraform-codepipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"

    # encryption_key {
    #   id   = data.aws_kms_alias.s3kmskey.arn
    #   type = "KMS"
    # }
  }

  stage {
    name = "Source"

    action {
      name     = "Source"
      category = "Source"
      owner    = "ThirdParty"
      provider = "GitHub"
      version  = "1"
      # output_artifacts = ["source_output"]

      configuration = {
        OAuthToken = var.GITHUB_TOKEN
        Owner  = "algha"
        Repo   = "algha/aws-codedeploy-samples"
        Branch = "master"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name     = "DeployToEC2"
      category = "Deploy"
      owner    = "AWS"
      provider = "CodeDeploy"
      # input_artifacts = ["demo-docker-build"]
      version = "1"

      configuration = {
        ApplicationName                = aws_codedeploy_app.main.name
        DeploymentGroupName            = aws_codedeploy_deployment_group.main.deployment_group_name
        TaskDefinitionTemplateArtifact = "demo-docker-build"
        AppSpecTemplateArtifact        = "demo-docker-build"
      }
    }
  }
}