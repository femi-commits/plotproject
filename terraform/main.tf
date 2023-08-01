##Provider

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}


resource "aws_security_group" "plotly_sg" {
  name_prefix = "plotly_sg"

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.plotly_port
    to_port     = var.plotly_port
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
    Name = "plotly_sg"
  }
}


##Instance

resource "aws_instance" "plotly_vm" {
  ami           = "ami-053b0d53c279acc90" # Replace with your desired AMI ID for the instance
  instance_type = "t2.medium"
  key_name      = var.key_pair
  security_groups = [aws_security_group.example_sg.id]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "PlotlyVM"
  }
}
