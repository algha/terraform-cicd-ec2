terraform {
  backend "s3" {
    bucket  = "uyghur-terraform"
    region  = "ap-northeast-1"
    profile = "uyghur"
    key     = "terraform/cicd-test/terraform.tfstate"
    encrypt = true
  }
}
