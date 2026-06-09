output "bucket_name" {
  value = aws_s3_bucket.site.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.site.arn
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.site.id
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.site.domain_name
}

output "site_url" {
  value = "https://${local.domain_name}"
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.site.arn
}

output "regional_acm_certificate_arn" {
  value = aws_acm_certificate.regional_wildcard.arn
}
