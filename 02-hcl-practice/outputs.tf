output "full_name" {
  description = "full name of app/deployment"
  value       = local.full_name
}

output "tier" {
  description = "deployment tier"
  value       = local.env == "prod" ? "high" : "low"
}
