resource "aws_route53_record" "www" {
  zone_id = var.hosted_zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = "600"
  records = [var.site_domain]
}

resource "aws_route53_record" "apex" {
  zone_id = var.hosted_zone_id
  name    = var.site_domain
  type    = "A"
  alias {
    name                   = module.cloudfront.wordpress_cloudfront_distribution_domain_name
    zone_id                = module.cloudfront.wordpress_cloudfront_distrubtion_hostedzone_id
    evaluate_target_health = false
  }
}

resource "aws_ses_domain_identity" "ses_domain_id" {
  domain = var.site_domain
}

resource "aws_ses_domain_dkim" "ses_domain_dkim" {
  domain = aws_ses_domain_identity.ses_domain_id.domain
}

resource "aws_route53_record" "wordpress_dkim_record" {
  count   = 3
  zone_id = var.hosted_zone_id
  name    = "${element(aws_ses_domain_dkim.ses_domain_dkim.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.ses_domain_dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}
