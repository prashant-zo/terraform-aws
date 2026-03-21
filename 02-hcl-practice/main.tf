terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "us-east-1"
}

locals {
  app_name  = "myapp"
  env       = "dev"
  full_name = "${local.app_name}-${local.env}"
}
