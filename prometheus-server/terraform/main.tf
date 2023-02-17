terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "prometheusSecGroup" {
  description = "Open SSH 22, 9090, and 9093"
  name = "prometheusSecGroup"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 9090
    to_port = 9090
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 9093
    to_port = 9093
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_instance" "prometheusServer" {
  instance_type = "t2.micro"
  security_groups = [aws_security_group.prometheusSecGroup.name]
  key_name = "prometheus-key-pair"
  ami = "ami-00874d747dde814fa"

  tags = {
    "Name" = "prometheus-server"
  }
}

output "prometheus-ip" {
  description = "Public IP of the prometheus server"
  value = aws_instance.prometheusServer.public_ip
}

output "prometheus-dns" {
  description = "DNS of the prometheus server"
  value = aws_instance.prometheusServer.public_dns
}