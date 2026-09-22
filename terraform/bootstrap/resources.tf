resource "aws_s3_bucket" "resources" {
  bucket = "${var.environment}-wds-resources"
}

resource "aws_s3_bucket_versioning" "resources" {
  bucket = aws_s3_bucket.resources.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "resources" {
  bucket = aws_s3_bucket.resources.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "resources" {
  bucket = aws_s3_bucket.resources.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
