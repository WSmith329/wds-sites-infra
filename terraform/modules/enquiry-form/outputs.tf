output "lambda_name" {
  value = aws_lambda_function.enquiry.function_name
}

output "route_key" {
  value = aws_apigatewayv2_route.enquiry.route_key
}
