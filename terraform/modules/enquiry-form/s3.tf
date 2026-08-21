resource "aws_iam_role_policy" "s3" {
  role = aws_iam_role.lambda.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "s3:GetObject",
      ]

      Resource = [
        "${data.aws_s3_bucket.resources_bucket.arn}/${var.site_dir}/emails/enquiry_form.html",
        "${data.aws_s3_bucket.resources_bucket.arn}/${var.site_dir}/emails/enquiry_receipt.html",
      ]
    }]
  })
}
