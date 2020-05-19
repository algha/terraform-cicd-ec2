variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "ap-northeast-1"
}

variable "VPC_ID" {}

variable "SUBNET_MAIN_PUBLIC_1" {}

variable "AMIS" {
  type = map(string)
  default = {
    ap-northeast-1 = "ami-0f310fced6141e627"
  }
}



variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}

variable "PATH_PUBLIC_KEY" {
  default = "./keys/cicd.pub"
}

variable "PATH_PRIVATE_KEY" {
  default = "./keys/cicd"
}


variable "GITHUB_TOKEN" {
  default = ""
}