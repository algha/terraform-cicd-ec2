module "web-server" {
  source = "./web-server"

  AppName          = "cicd"
  AMI              = var.AMI
  InstanceType     = "t2.micro"
  InstanceUsername = "ec2-user"
  VpcId            = var.VPC_ID
  SubnetId         = var.SUBNET_MAIN_PUBLIC_1
}

module "cicd-pipeline" {
  source = "./cicd-pipeline"

  AppName          = "cicd"
  Company          = "algha"
  SourceOAuthToken = var.SourceOAuthToken
  SourceOwner      = "algha"
  SourceRepository = "aws-codedeploy-samples"
  SourceBranch     = "master"
}