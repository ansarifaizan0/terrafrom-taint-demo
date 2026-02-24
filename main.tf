# main.tf
provider "aws" {
  region = "us-east-1"
}

# 👇 auto fetch latest Amazon Linux 2 AMI for your region
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id   # 👈 dynamic, always correct
  instance_type = "t2.micro"

  tags = {
    Name = "taint-demo-server"
  }
}
