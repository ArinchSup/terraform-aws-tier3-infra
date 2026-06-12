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

variable "allowed_ssh_cidr" {
  description = "CISR allow SSH to bastion (home IP)"
  type        = string
  default     = "0.0.0.0/0" //make it 0.0.0.0 for now (curl ifconfig.me to get your IP)
}

variable "ssh_public_key_path" {
  description = "Path to your SSH public key file"
  type        = string
  default     = "~/.ssh/terraform_3tier.pub"
}

variable "instance_type" {
  description = "ec2 instance type for app"
  type        = string
  default     = "13.micro"
}

variable "asg_min_size" {
  type    = number
  default = 2
}

variable "asg_max_size" {
  type    = number
  default = 4
}

variable "asg_desired_capacity" {
  type    = number
  default = 2
}

variable "db_username" {
  description = "Master DB username"
  type        = string
  default     = "appuser"
}
variable "db_password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "initial database name"
  type        = string
  default     = "appdb"
}

variable "db_instance_class" {
  description = "RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Storage capacity"
  type        = number
  default     = 20
}

variable "db_multi_az" {
  description = "Multi AZZ for RDS"
  type        = bool
  default     = false
}