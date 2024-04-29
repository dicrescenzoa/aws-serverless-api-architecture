terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.44.0"
    }
  }
  required_version = ">= 1.5.5"

  backend "s3" {}
}

provider "aws" {
  region = var.region
  profile = var.aws_profile
}

module "go-serverless-api-lambda" {
  source = "./lambda/go-serverless-api-lambda"

  aws_api_gateway_rest_api_execution_arn    = aws_api_gateway_rest_api.api_gateway.execution_arn
  aws_api_gateway_rest_api_id               = aws_api_gateway_rest_api.api_gateway.id
  aws_api_gateway_rest_api_root_resource_id = aws_api_gateway_rest_api.api_gateway.root_resource_id

  environment    = var.environment
  region         = var.region
  account_number = var.account_number
  project_name   = var.project_name
}

module "fastify-serverless-api-lambda" {
  source = "./lambda/fastify-serverless-api-lambda"

  aws_api_gateway_rest_api_execution_arn    = aws_api_gateway_rest_api.api_gateway.execution_arn
  aws_api_gateway_rest_api_id               = aws_api_gateway_rest_api.api_gateway.id
  aws_api_gateway_rest_api_root_resource_id = aws_api_gateway_rest_api.api_gateway.root_resource_id

  environment    = var.environment
  region         = var.region
  account_number = var.account_number
  project_name   = var.project_name
}

module "go-serverless-api-lambda-docker" {
  source = "./lambda/go-serverless-api-lambda-docker"

  aws_api_gateway_rest_api_execution_arn    = aws_api_gateway_rest_api.api_gateway.execution_arn
  aws_api_gateway_rest_api_id               = aws_api_gateway_rest_api.api_gateway.id
  aws_api_gateway_rest_api_root_resource_id = aws_api_gateway_rest_api.api_gateway.root_resource_id

  environment    = var.environment
  region         = var.region
  account_number = var.account_number
  project_name   = var.project_name
}