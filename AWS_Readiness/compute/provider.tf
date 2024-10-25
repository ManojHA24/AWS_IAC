terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = var.location
  access_key = ""
  secret_key = ""
  # assume_role {
  #   role_arn     = "arn:aws:iam::775188627313:user/manoj_ha"
  # }
}