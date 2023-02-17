terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "appSecGroup" {
  description = "Open SSH 22, 9090, and 9093"
  name        = "appSecGroup"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "appServer" {
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.appSecGroup.name]
  key_name        = "prometheus-key-pair"
  ami             = "ami-00874d747dde814fa"

  tags = {
    "Name" = "app-server"
  }
}

output "app-ip" {
  description = "Public IP of the app server"
  value       = aws_instance.appServer.public_ip
}

output "app-dns" {
  description = "DNS of the app server"
  value       = aws_instance.appServer.public_dns
}