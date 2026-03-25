output "instance_id" {
  description = "EC2 instance id"
  value       = aws_instance.this.id
}

output "instance_public_id" {
  description = "EC2 instance public id"
  value       = aws_instance.this.public_id
}

output "instance_private_id" {
  description = "EC2 instance private id"
  value       = aws_instance.this.private_id
}

output "instance_arn" {
  description = "EC2 instance arn"
  value       = aws_instance.this.arn
}
