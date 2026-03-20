variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "my-app"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  # validation block
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging or pod."
  }
}
