variable "bucket_name" {
  description = "Name of the s3 bucket"
  type        = string
}

variable "environment" {
  description = "Deployment Envirnoment"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Enable server-side encryption"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Enable force destroy even if bucket is non-empty"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
