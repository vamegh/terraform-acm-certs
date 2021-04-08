variable "create_certificate" {
  type = bool
  description = "Whether to create ACM certificate"
}

variable "validate_certificate" {
  description = "Whether to validate certificate by creating Route53 record"
}

variable "wait_for_validation" {
  description = "Whether to wait for the validation to complete"
}

variable "domain_name" {
  type        = string
  description = "Primary certificate domain name"
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "Subject alternative domain names"
}

variable "dns_zone_id" {
  type        = string
  description = "Route 53 Zone ID for DNS validation records"
}

variable "validation_record_ttl" {
  default     = "60"
  description = "Route 53 time-to-live for validation records"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags to attach to the ACM certificate"
}

variable "validation_method" {
  description = "Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  default     = "DNS"
}

