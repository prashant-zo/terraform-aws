output "instance_id" {
  description = "EC2 instance id"
  value       = aws_instance.demo.id
}

output "public_ip" {
  description = "EC2 public ip"
  value       = aws_instance.demo.public_ip
}

output "ami_used" {
  description = "AMI used in aws"
  value       = data.aws_ami.latest.id
}
