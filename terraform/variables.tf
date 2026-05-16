variable "aws_region" {
  description = "any region (ap-southeast-1 (Singapore) for now)"
  type = string
  default = "ap-southeast-1"
}

variable "project_name" {
  description = "the project name"
  type = string
  default = "tier3"
}

variable "environment" {
  description = "Deployment environment"
  type = string
  default = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type = string
  default = "10.0.0.0/16"
}