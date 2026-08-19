resource "aws_lambda_function" "enquiry" {
  function_name = "${var.environment}-${var.site_name}-enquiry-form-handler"

  s3_bucket = "${var.environment}-wds-lambda-artifacts"
  s3_key    = "${var.site_dir}/enquiry_form.zip"

  source_code_hash = filebase64sha256("${path.root}/build/enquiry_form.zip")

  handler = "lambda_handler.lambda_handler"
  runtime = "python3.13"
  role    = aws_iam_role.lambda.arn

  environment {
    variables = merge(
      {
        OWNER_EMAIL               = var.owner_email
        FROM_EMAIL                = var.from_email
        RESOURCES_BUCKET          = data.aws_s3_bucket.resources_bucket.bucket
        ENQUIRY_FORM_TEMPLATE_KEY = "${var.site_dir}/emails/enquiry_form.html"
        ENQUIRY_RECEIPT_TEMPLATE_KEY = "${var.site_dir}/emails/enquiry_receipt.html"
      },
      var.from_display_name != null ? { FROM_DISPLAY_NAME = var.from_display_name } : {}
    )
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
