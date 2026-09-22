resource "aws_apigatewayv2_integration" "enquiry" {
  api_id = var.api_id

  integration_type = "AWS_PROXY"

  integration_uri = aws_lambda_function.enquiry.invoke_arn

  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "enquiry" {
  api_id = var.api_id

  route_key = "POST /enquiry"

  target = "integrations/${aws_apigatewayv2_integration.enquiry.id}"
}
