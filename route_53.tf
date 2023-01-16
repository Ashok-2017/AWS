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
  name = "one1"
  type = "A"
  zone_id = 
  alias {
    evaluate_target_health = true
    name = 
    zone_id = 
  }
} 
  
