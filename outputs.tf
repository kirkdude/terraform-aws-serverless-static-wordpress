output "cloudfront_ssl_arn" {
  value       = aws_acm_certificate.wordpress_site.arn
  description = "The ARN of the ACM certificate used by CloudFront."
}

output "wordpress_ecr_repository" {
  value       = aws_ecr_repository.serverless_wordpress.name
  description = "The name of the ECR repository where wordpress image is stored."
}

output "codebuild_project_name" {
  value       = module.codebuild.codebuild_project_name
  description = "The name of the created Wordpress codebuild project."
}

output "codebuild_package_etag" {
  value       = module.codebuild.codebuild_package_etag
  description = "The etag of the codebuild package file."
}

output "wordpress_waf_arn" {
  value = module.waf.waf_acl_arn
}

output "cloudfront_bucket_arn" {
  value = module.cloudfront.wordpress_bucket_arn
}

output "cloudfront_domain_name" {
  value = module.cloudfront.wordpress_cloudfront_distribution_domain_name
}

output "cloudfront_hostedzone_id" {
  value = module.cloudfront.wordpress_cloudfront_distrubtion_hostedzone_id
}

output "ses_domain_dkim" {
  value = aws_ses_domain_dkim.ses_domain_dkim.*
}

output "wordpress_dkim_record" {
  value = aws_route53_record.wordpress_dkim_record.*
}
