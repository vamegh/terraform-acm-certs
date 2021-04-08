output "validation_arn" {
  value = flatten(aws_acm_certificate_validation.cert.*.certificate_arn)
}

output "cert_arn" {
  value = flatten(aws_acm_certificate.cert.*.arn)
}

output "acm_cert_domain_validation_options" {
  description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
  value       = flatten(aws_acm_certificate.cert.*.domain_validation_options)
}

