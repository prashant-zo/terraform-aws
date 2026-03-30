# main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# ══════════════════════════════════════════════════════════════
# DATA SOURCE 1 — Current AWS Account ID, Region, Caller Info
# ══════════════════════════════════════════════════════════════
# No filter needed — just reads your current session
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {} # "aws" or "aws-cn" or "aws-us-gov"

# Now use them:
locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
  partition  = data.aws_partition.current.partition

  # Build ARN prefix dynamically — no hardcoding!
  arn_prefix = "arn:${local.partition}:s3:::${local.account_id}"
}

# ══════════════════════════════════════════════════════════════
# DATA SOURCE 2 — Latest Amazon Linux 2023 AMI
# ══════════════════════════════════════════════════════════════
# This always fetches the CURRENT latest AMI automatically
# No more hardcoding ami-0c55b159cbfafe1f0 which goes stale!
data "aws_ami" "amazon_linux" {
  most_recent = true       # get the newest one
  owners      = ["amazon"] # only trust Amazon's official AMIs

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"] # Amazon Linux 2023 pattern
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# ══════════════════════════════════════════════════════════════
# DATA SOURCE 3 — Ubuntu 22.04 LTS AMI
# ══════════════════════════════════════════════════════════════
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's official AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ══════════════════════════════════════════════════════════════
# DATA SOURCE 4 — Available Availability Zones
# ══════════════════════════════════════════════════════════════
# Dynamically get AZs for current region — no hardcoding!
data "aws_availability_zones" "available" {
  state = "available" # only get usable AZs
}

# ══════════════════════════════════════════════════════════════
# DATA SOURCE 5 — Existing VPC (created by another team)
# ══════════════════════════════════════════════════════════════
# Scenario: Network team created a VPC, you deploy into it
data "aws_vpc" "existing" {
  # Find VPC by tag
  tags = {
    Name        = "main-vpc"
    Environment = var.environment
  }
}

# Alternative: find VPC by its CIDR block
data "aws_vpc" "by_cidr" {
  cidr_block = "10.0.0.0/16"
}

# ══════════════════════════════════════════════════════════════
# DATA SOURCE 6 — Subnets inside an existing VPC
# ══════════════════════════════════════════════════════════════
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id] # reference the VPC data source
  }

  tags = {
    Type = "public"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }

  tags = {
    Type = "private"
  }
}

# ══════════════════════════════════════════════════════════════
# DATA SOURCE 7 — Existing Security Group
# ══════════════════════════════════════════════════════════════
data "aws_security_group" "existing_sg" {
  name   = "default"
  vpc_id = data.aws_vpc.existing.id
}

# ══════════════════════════════════════════════════════════════
# DATA SOURCE 8 — AWS Secrets Manager secret
# ══════════════════════════════════════════════════════════════
data "aws_secretsmanager_secret" "db_secret" {
  name = "prod/myapp/database"
}

data "aws_secretsmanager_secret_version" "db_secret" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}

# Use it in a resource
locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.db_secret.secret_string
  )
  db_password = local.db_creds["password"]
  db_username = local.db_creds["username"]
}

# ══════════════════════════════════════════════════════════════
# DATA SOURCE 9 — SSM Parameter Store
# ══════════════════════════════════════════════════════════════
data "aws_ssm_parameter" "ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}
# This is AWS's own SSM path that always has latest Amazon Linux AMI ID

data "aws_ssm_parameter" "db_password" {
  name            = "/myapp/dev/db_password"
  with_decryption = true # decrypt SecureString parameters
}

# ══════════════════════════════════════════════════════════════
# DATA SOURCE 10 — IAM Policy Document (build IAM policies)
# ══════════════════════════════════════════════════════════════
data "aws_iam_policy_document" "s3_read_policy" {
  statement {
    sid    = "AllowS3Read"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}

# Use the policy document in an IAM policy
resource "aws_iam_policy" "s3_read" {
  name   = "s3-read-policy"
  policy = data.aws_iam_policy_document.s3_read_policy.json
}
