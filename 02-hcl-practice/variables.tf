variable "environment" {
  description = "Environment for deployment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment should be either dev, staging or prod."
  }
}

variable "instance_count" {
  description = "Count number of instances"
  type        = number
  default     = 1
}

variable "enable_monitoring" {
  description = "Monitor deployment"
  type        = bool
  default     = false
}

variable "allowed_ports" {
  description = "Allowed port for deployment"
  type        = list(number)
  default     = [80, 443]
}

variable "common_tags" {
  description = "Three common tags mapping"
  type        = map(string)

  default = {
    Project = "Terraform"
    Cloud   = "AWS"
    Network = "vpc"
  }

  validation {
    condition     = length(var.common_tags) >= 3
    error_message = "There should atleast 3 tags"
  }
}
