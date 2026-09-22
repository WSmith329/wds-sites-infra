resource "aws_ses_domain_identity" "main" {
  domain = var.root_domain
}

resource "aws_ses_domain_dkim" "main" {
  domain = aws_ses_domain_identity.main.domain
}

resource "aws_route53_record" "ses_verification" {
  zone_id = data.aws_route53_zone.site.zone_id
  name    = "_amazonses.${var.root_domain}"
  type    = "TXT"
  ttl     = 600

  records = [
    aws_ses_domain_identity.main.verification_token
  ]
}

resource "aws_route53_record" "ses_dkim" {
  count = 3

  zone_id = data.aws_route53_zone.site.zone_id

  name = "${aws_ses_domain_dkim.main.dkim_tokens[count.index]}._domainkey.${var.root_domain}"
  type = "CNAME"
  ttl  = 600

  records = [
    "${aws_ses_domain_dkim.main.dkim_tokens[count.index]}.dkim.amazonses.com"
  ]
}

resource "aws_ses_domain_mail_from" "main" {
  domain           = aws_ses_domain_identity.main.domain
  mail_from_domain = "mail.${var.root_domain}"
}
