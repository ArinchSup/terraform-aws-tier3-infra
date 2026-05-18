variable "aws_region" {
  description = "any region (ap-southeast-1 (Singapore) for now)"
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "the project name"
  type        = string
  default     = "tier3"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private apps"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for private db"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}