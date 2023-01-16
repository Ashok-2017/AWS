locals {
  create_records = var.alb_dns_name == "" ? 0 : var.dns_zone_id == "" ? 0 : 1
}

resource "aws_route53_record" "dns_record" {
  count = local.create_records
  zone_id = var.dns
  name = var.hostname
  type = "A"
  alias {
    name = var.alb_name
    zone = var.alb_id
    evaluate_target_health = false
  }
  allow_overwrite = false
}

resource "aws_route53_record" "refer" {
  name = " "
  type = "A"
  zone_id = 
  alias {
    evaluate_target_health = true
    name = 
    zone_id = 
  }
} 

resource "aws_route53_zone" "t2" {
  name = "  "
}

resource "aws_acm_certificate" "t3" {
  domain_name = " "
  validation_method = "DNS"
  subject_alternative_names = ["^.*$"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "t4" {
  count = 2
  certificate_arn = aws_acm_certificate.t3.arn
  validation_record_fqdns = 
}  
  



  
