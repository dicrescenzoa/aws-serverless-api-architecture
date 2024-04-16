

resource "aws_lambda_function" "lambda_fn" {
  function_name = format("%s-%s", var.lambda_fn_name, var.environment)

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.s3_object_api_lambda.key

  runtime = "nodejs20.x"
  architectures = ["x86_64"]
  handler = "run.sh"

  source_code_hash = filemd5(format("%s/bootstrap.zip", var.lambda_folder_location))

  role = aws_iam_role.lambda_role.arn

  environment {
    variables = {
      "AWS_LAMBDA_EXEC_WRAPPER": "/opt/bootstrap"
      "PORT": 8000
      "BASE_API_PATH": format("/%s", var.lambda_base_path)
    }
  }

  layers = [
    "arn:aws:lambda:${var.region}:753240598075:layer:LambdaAdapterLayerX86:21"
  ]
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