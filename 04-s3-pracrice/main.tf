terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

resource "random_id" "bucket_suffix" {
  count       = 2
  byte_length = 4
}

resource "aws_s3_bucket" "main" {
  bucket = "${var.project}-${var.environment}-${random_id.bucket_suffix[0].hex}"

  lifecycle {
    prevent_destroy = true
  }

  tags = local.common_tags
}

resource "aws_s3_bucket" "countbucket" {
  count = 2

  bucket        = "bucket-${count.index}-${random_id.bucket_suffix[count.index].hex}"
  force_destroy = true

  tags = merge(local.common_tags, {
    Name = "bucket-${count.index}"
    Team = "devops"
  })
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "count" {
  count  = 2
  bucket = aws_s3_bucket.countbucket[count.index].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "count" {
  count  = 2
  bucket = aws_s3_bucket.countbucket[count.index].id

  versioning_configuration {
    status = "Enabled"
  }
}

locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}
