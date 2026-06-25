terraform {
  required_version = ">=1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
  backend "s3" {
    bucket = "terraform-tier3-bucket-ar"
    key    = "tier3/dev/terraform.tfstate"
    region = "ap-southeast-1"
    #dynamodb_table = "tier3-dev-dynamodb" this is old one
    use_lockfile = true #use this instead
    encrypt      = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  }
}