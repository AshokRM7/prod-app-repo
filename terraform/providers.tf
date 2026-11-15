terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "production-app-tfstate-terraform"
    key          = "production-app/terraform.tfstate"
    region       = "ap-south-1"
    profile      = "learning-Admin"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "learning-Admin"

  default_tags {
    tags = {
      project = "learning"
    }
  }
}