variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "ap-northeast-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    ap-northeast-1 = "ami-0318ecd6d05daa212"
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


