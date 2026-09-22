resource "aws_iam_role_policy" "ses" {
  role = aws_iam_role.lambda.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ]

      Resource = "*"
    }]
  })
}
