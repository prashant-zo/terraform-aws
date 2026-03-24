
output "bucket_name" {
  description = "Bucket name"
  value       = aws_s3_bucket.main.bucket
}

output "count_bucket_name" {
  description = "Count Bucket name list"
  value       = aws_s3_bucket.countbucket[*].bucket
}

output "bucket_arns" {
  description = "ARNs of all buckets"
  value       = aws_s3_bucket.countbucket[*].arn
}
