data "aws_ecr_repository" "lambda_repository" {
  name = "${var.project_name}-${var.environment}-go-serverless-api-repository"
}

resource "aws_lambda_function" "lambda_fn" {
  function_name = format("%s-%s", var.lambda_fn_name, var.environment)

  image_uri    = "${data.aws_ecr_repository.lambda_repository.repository_url}:latest"

  architectures = ["arm64"]

  role = aws_iam_role.lambda_role.arn
  package_type = "Image"

  environment {
    variables = {
      "PORT": 8000
      "GIN_MODE": "release"
      "BASE_API_PATH": format("/%s", var.lambda_base_path)
    }
  }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/${aws_lambda_function.lambda_fn.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role" "lambda_role" {
  name = format("%s-%s-role", var.lambda_fn_name, var.environment)

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_permission" "lambda_permission_api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_fn.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${var.aws_api_gateway_rest_api_execution_arn}/*/*"
}