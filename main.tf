locals {
  domain = "pnivch.pp.ua"
  zone_id = "Z0195705SKP1BRPCP7RP"
}

resource "aws_route53_record" "domain_redirect_to_s3" {
  zone_id = local.zone_id
  name    = "lab1.${local.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [ aws_s3_bucket_website_configuration.lab1_website_configuration.website_endpoint ]
}