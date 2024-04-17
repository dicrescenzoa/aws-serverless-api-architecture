resource "aws_api_gateway_resource" "api_gateway_root" {
  rest_api_id = var.aws_api_gateway_rest_api_id
  parent_id   = var.aws_api_gateway_rest_api_root_resource_id
  path_part   = var.lambda_base_path
}

resource "aws_api_gateway_method" "api_gateway_root_method" {
  rest_api_id   = var.aws_api_gateway_rest_api_id
  resource_id   = aws_api_gateway_resource.api_gateway_root.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_resource" "api_gateway_proxy" {
  rest_api_id = var.aws_api_gateway_rest_api_id
  parent_id   = aws_api_gateway_resource.api_gateway_root.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "api_gateway_proxy_method" {
  rest_api_id   = var.aws_api_gateway_rest_api_id
  resource_id   = aws_api_gateway_resource.api_gateway_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "proxy_integration" {
  rest_api_id             = var.aws_api_gateway_rest_api_id
  resource_id             = aws_api_gateway_resource.api_gateway_proxy.id
  http_method             = aws_api_gateway_method.api_gateway_proxy_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_fn.invoke_arn
}

resource "aws_api_gateway_integration" "root_integration" {
  rest_api_id             = var.aws_api_gateway_rest_api_id
  resource_id             = aws_api_gateway_resource.api_gateway_root.id
  http_method             = aws_api_gateway_method.api_gateway_root_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_fn.invoke_arn
}


output "fastify_serverless_api_proxy_integration" {
  value = aws_api_gateway_integration.proxy_integration
}

output "fastify_serverless_api_root_integration" {
  value = aws_api_gateway_integration.root_integration
}