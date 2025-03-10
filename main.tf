terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"

  # assume_role {
  #   role_arn = "arn:aws:iam::941377134910:role/AdministratorRole"
  # }
}