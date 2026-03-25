terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "prashant-terraform-state-2026"
    key            = "environments/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

module "app_bucket" {
  source = "../../modules/s3"

  bucket_name       = "${var.project}-${var.environment}-app"
  environment       = var.environment
  enable_versioning = true
  force_destroy     = true

  tags = {
    Project = var.project
    Owner   = "Parshant"
  }
}

module "logs_bucket" {
  source = "../../modules/s3"

  bucket_name       = "${var.project}-${var.environment}-logs"
  environment       = var.environment
  enable_versioning = false
  force_destroy     = true

  tags = {
    Project = var.project
    Owner   = "Prashant"
  }
}
