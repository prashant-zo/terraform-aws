output "bucket_id" {
  description = "bucket name/id"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "bucket arn"
  value       = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  description = "bucket domain name"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "bucket regional domain name"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}
