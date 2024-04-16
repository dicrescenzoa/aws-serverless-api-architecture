resource "aws_api_gateway_rest_api" "api_gateway" {
  name = format("api-gateway-%s-%s", var.project_name, var.environment)
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  depends_on = [
    module.go-serverless-api-lambda.go_serverless_api_proxy_integration,
    module.go-serverless-api-lambda.go_serverless_api_root_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = var.environment
}