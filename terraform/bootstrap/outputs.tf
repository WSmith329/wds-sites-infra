output "terraform_state_bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "lambda_artifacts_bucket" {
  value = aws_s3_bucket.lambda_artifacts.bucket
}
