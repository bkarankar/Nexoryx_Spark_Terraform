terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "spark_sg" {
  name        = "spark-cluster-sg"
  description = "Spark Cluster Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    from_port   = 7077
    to_port     = 7077
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4040
    to_port     = 4050
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

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "spark_master" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.master_instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.spark_sg.id]

  user_data = templatefile("${path.module}/templates/master.sh.tpl", {})

  tags = {
    Name = "spark-master"
  }
}

resource "aws_instance" "spark_workers" {
  count                  = var.worker_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.worker_instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.spark_sg.id]

  user_data = templatefile("${path.module}/templates/worker.sh.tpl", {
    master_ip = aws_instance.spark_master.private_ip
  })

  tags = {
    Name = "spark-worker-${count.index + 1}"
  }

  depends_on = [aws_instance.spark_master]
}