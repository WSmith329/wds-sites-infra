resource "aws_apigatewayv2_api" "enquiry" {
  name          = "${var.site_name}-enquiry-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = var.environment == "prod" ? [
      "https://${var.root_domain}",
      "https://www.${var.root_domain}"
      ] : [
      "https://${var.environment}.${var.root_domain}",
      "https://www.${var.environment}.${var.root_domain}"
    ]
    allow_methods = ["POST", "OPTIONS"]
    allow_headers = ["content-type"]
    max_age       = 300
  }
}
