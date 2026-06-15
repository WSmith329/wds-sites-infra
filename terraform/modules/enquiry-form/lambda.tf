data "aws_s3_object" "enquiry_form" {
  bucket = aws_s3_bucket.lambda_artifacts.bucket
  key    = "${var.site_dir}/enquiry_form.zip"
}

resource "aws_lambda_function" "enquiry" {
  function_name = "enquiry-form-handler"

  s3_bucket         = data.aws_s3_object.enquiry_form.bucket
  s3_key            = data.aws_s3_object.enquiry_form.key
  s3_object_version = data.aws_s3_object.enquiry_form.version_id

  handler = "lambda_handler.lambda_handler"
  runtime = "python3.13"
  role    = aws_iam_role.lambda.arn

  environment {
    variables = {
      OWNER_EMAIL = var.owner_email
      FROM_EMAIL  = var.from_email
    }
  }
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id = "AllowExecutionFromApiGateway"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.enquiry.function_name

  principal = "apigateway.amazonaws.com"

  source_arn = "${var.execution_arn}/*/*"
}
