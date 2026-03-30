# ec2_example.tf

# Fetch latest Amazon Linux 2023 AMI dynamically
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# Fetch AZs dynamically
data "aws_availability_zones" "azs" {
  state = "available"
}

# Create EC2 using the dynamic AMI
resource "aws_instance" "web" {
  # ami_id comes from data source — always up to date
  ami           = data.aws_ami.al2023.id
  instance_type = var.instance_type

  # Use first available AZ dynamically
  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name     = "${var.project}-web"
    AMI_Used = data.aws_ami.al2023.name # store AMI name in tag
  }
}
