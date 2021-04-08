locals {
  length_san = length(var.subject_alternative_names) + 1
}

resource "aws_acm_certificate" "cert" {
  count       = var.create_certificate ? 1 : 0
  domain_name = var.domain_name

  subject_alternative_names = var.subject_alternative_names

  validation_method = var.validation_method

  tags = var.tags
}

resource "aws_route53_record" "cert_validation" {
  count = local.length_san

  name    = aws_acm_certificate.cert.0.domain_validation_options[count.index]["resource_record_name"]
  type    = aws_acm_certificate.cert.0.domain_validation_options[count.index]["resource_record_type"]
  zone_id = var.dns_zone_id

  records = [
    aws_acm_certificate.cert.0.domain_validation_options[count.index]["resource_record_value"],
  ]

  ttl = var.validation_record_ttl
}

resource "aws_acm_certificate_validation" "cert" {
  count           = var.create_certificate && var.validation_method == "DNS" && var.validate_certificate && var.wait_for_validation ? 1 : 0
  certificate_arn = aws_acm_certificate.cert[0].arn

  validation_record_fqdns = aws_route53_record.cert_validation.*.fqdn
}

