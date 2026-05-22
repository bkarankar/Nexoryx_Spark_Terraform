variable "aws_region" {
  default = "ap-south-1"
}

variable "key_pair_name" {
  description = "AWS EC2 Key Pair Name"
  type        = string
}

variable "allowed_ssh_cidr" {
  default = "0.0.0.0/0"
}

variable "master_instance_type" {
  default = "t3.large"
}

variable "worker_instance_type" {
  default = "t3.large"
}

variable "worker_count" {
  default = 20
}