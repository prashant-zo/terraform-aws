# outputs.tf

output "current_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "current_region" {
  value = data.aws_region.current.name
}

output "amazon_linux_ami_id" {
  description = "Latest Amazon Linux 2023 AMI ID"
  value       = data.aws_ami.amazon_linux.id
}

output "amazon_linux_ami_name" {
  description = "Name of the AMI (shows version)"
  value       = data.aws_ami.amazon_linux.name
}

output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "available_azs" {
  description = "All AZs available in current region"
  value       = data.aws_availability_zones.available.names
}

output "first_az" {
  value = data.aws_availability_zones.available.names[0]
}

output "second_az" {
  value = data.aws_availability_zones.available.names[1]
}
