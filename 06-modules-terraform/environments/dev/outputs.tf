output "app_bucket_name" {
  value = module.app_bucket.bucket_id
}

output "app_bucket_arn" {
  value = module.app_bucket.bucket_arn
}

output "logs_bucket_name" {
  value = module.logs_bucket.bucket_id
}
