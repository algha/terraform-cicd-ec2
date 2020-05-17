terraform {
  backend "s3" {
    bucket  = "uyghur-terraform"
    region  = "ap-northeast-1"
    profile = "uyghur"
    key     = "terraform.tfstate"
    encrypt = true
  }
}
