output "api_gateway_base_url" {
  value = aws_api_gateway_deployment.api_gateway_deployment.invoke_url
}

output "api_gateway_base_url_go_serverless_api_lambda" {
  value = format("%s/%s", aws_api_gateway_deployment.api_gateway_deployment.invoke_url, module.go-serverless-api-lambda.lambda_base_path)
}

output "api_gateway_base_url_fastapi_serverless_api_lambda" {
  value = format("%s/%s", aws_api_gateway_deployment.api_gateway_deployment.invoke_url, module.fastify-serverless-api-lambda.lambda_base_path)
}

output "aws_api_gateway_rest_api_execution_arn" {
  value = aws_api_gateway_rest_api.api_gateway.execution_arn
}