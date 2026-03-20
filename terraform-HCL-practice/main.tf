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
  region = var.aws_region
}

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }

  server_name = "${var.project_name}-${var.environment}-server"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.project_name}-${var.environment}-bucket-2024"

  tags = local.common_tags
}
