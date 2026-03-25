variable "instance_name" {
  description = "instance name for ec2"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID used for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"

  validation {
    condition = consists([
      "t2.micro", "t2.small", "t2.medium",
      "t3.micro", "t3.small", "t3.medium"
    ], var.instance_type)
    error_message = "Instance must be t2 or t3"
  }
}

variable "subnet_id" {
  description = "Subnet ID to launch instance in"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security groups IDs"
  type        = list(string)
  default     = []
}

variable "root_volume_size" {
  description = "root EBS volume size in gb"
  type        = number
  default     = 8
}

variable "enable_mointoring" {
  description = "Enable detailed cloudwatch monitoring"
  type        = bool
  default     = false
}

variable "use_data" {
  description = "User data script to run on launch"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply on resoureces"
  type        = map(string)
  default     = {}
}


