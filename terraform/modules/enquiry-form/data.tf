data "aws_s3_bucket" "resources_bucket" {
  bucket = "${var.environment}-wds-resources"
}
