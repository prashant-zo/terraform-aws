locals {
  tags = merge(var.tags, {
    Name        = var.instance_name
    Environment = var.environment
    Module      = "ec2"
  })
}

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  monitoring             = var.enable_monitoring

  user_data = var.user_data != "" ? var.user_data : null

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    encryption            = true
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [ami]
  }

  tags = local.tags
}
