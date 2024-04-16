terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.44.0"
    }
  }
  required_version = ">= 1.5.5"
}

provider "aws" {
  region = var.region
}