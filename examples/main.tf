provider "aws" {
  region = "eu-west-1"
}

data "aws_route53_zone" "zone" {
  name         = "example.com."
  private_zone = false
}

## this needs work
module "acm_cert" {
  source = "../"
  name   = "${var.name}"

  domain_name = "${data.aws_route53_zone.zone.name}"
  zone_id     = "${data.aws_route53_zone.zone.id}"

  subject_alternative_names = [
    "${format("%s.%s", var.name, data.aws_route53_zone.zone.name)}",
  ]

  tags = {
    Name = "${data.aws_route53_zone.zone.name}"
  }
}
