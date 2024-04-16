variable "aws_api_gateway_rest_api_execution_arn" {}
variable "aws_api_gateway_rest_api_root_resource_id" {}
variable "aws_api_gateway_rest_api_id" {}

variable "lambda_fn_name" {
    type        = string
    default     = "fastify-serverless-api-lambda"
}

variable "lambda_base_path" {
    type = string
    default = "fastify-serverless-api"
}

variable "lambda_folder_location" {
    type = string
    default = "../../fastify-serverless-api"
}

variable "environment" {}
variable "region" {}
variable "account_number" {}
variable "project_name" {}