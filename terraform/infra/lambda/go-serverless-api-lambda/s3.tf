resource "aws_s3_bucket" "lambda_bucket" {
  bucket = format("%s-bucket-%s", var.lambda_fn_name, var.environment)

  tags = {
    Name        = format("%s-bucket-%s", var.lambda_fn_name, var.environment)
    Environment = var.environment
  }
}

resource "aws_s3_object" "s3_object_api_lambda" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "bootstrap.zip"
  source = format("%s/bootstrap.zip", var.lambda_folder_location)

  etag = filemd5(format("%s/bootstrap.zip", var.lambda_folder_location))
}