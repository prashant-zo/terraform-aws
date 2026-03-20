output "bucket_name" {
  description = "The name of s3 bucket"
  value       = aws_s3_bucket.my_bucket.bucket
}

output "bucket_arn" {
  description = "The arn of s3 bucket"
  value       = aws_s3_bucket.my_bucket.arn
}

output "server_name_preview" {
  description = "What the server would be named"
  value       = local.server_name
}
