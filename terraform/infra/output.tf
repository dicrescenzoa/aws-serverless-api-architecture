output "api_gateway_base_url" {
  value = aws_api_gateway_deployment.api_gateway_deployment.invoke_url
}

output "aws_api_gateway_rest_api_execution_arn" {
  value = aws_api_gateway_rest_api.api_gateway.execution_arn
}