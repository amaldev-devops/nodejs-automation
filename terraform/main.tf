terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 7.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_key_pair" "nodejs_key" {
  key_name   = "nodejs-automation-key"
  public_key = file(pathexpand(var.public_key_path))
}

resource "aws_security_group" "nodejs_sg" {
  name        = "nodejs-automation-sg"
  description = "Security group for Node.js deployment"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nodejs-automation-sg"
  }
}

resource "aws_instance" "nodejs_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.nodejs_key.key_name
  vpc_security_group_ids = [aws_security_group.nodejs_sg.id]

  root_block_device {
    volume_size = 12
    volume_type = "gp3"
    encrypted   = true
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = "nodejs-automation-server"
  }
}
