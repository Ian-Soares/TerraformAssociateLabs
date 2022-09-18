variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "owner" {
  description = "Default tags for sandbox environment"
  type        = string
  default     = "iansoares"
}

variable "department" {
  description = "Default tags for sandbox environment"
  type        = string
  default     = "Academy"
}

variable "environment" {
  description = "Default tags for sandbox environment"
  type        = string
  default     = "EcsChallenge"
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "vpc-desafio-ecs"
}

variable "vpc_cidr_block" {
  type    = string
  default = "192.168.0.0/16"
}

variable "igw_name" {
  description = "Internet Gateway name"
  type        = string
  default     = "igw_ian"
}

variable "nat_gw_name" {
  description = "NAT Gateway name"
  type        = string
  default     = "nat_gw_ian"
}

variable "container_port" {
  description = "Container exposed port"
  type        = string
  default     = "80"
}

variable "container_image" {
  description = "ECS container image"
  type = string
  default = "613036180535.dkr.ecr.us-east-1.amazonaws.com/ecr-terraform-repository:latest"
}

variable "desired_count_service" {
  description = "The desired amount of services to be deployed"
  type = string
  default = "2"
}