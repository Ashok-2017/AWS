locals {
  create_records = var.alb_dns_name == ? 0 : var.dns_zone_id == " " ? 0 : 1
  http_count = var.alb_listener_arn == " " ? 0 : 1
  host_header_enabled = length(var.hostname) > 0
  host_header = local.host_header_enabled ? var.hostname : []
  path_pattern_enabled = length(var.path_pattern) > 0
  path_pattern_iterator = local.path_pattern_enabled ? var.path_pattern : ""
}

resource "aws_route53_record" "dns" {
  count = local.create_records
  zone_id = var.dns_zone_id
  name = var.hostname
  type = "A"
  alias {
    name = var.alb_dns_name
    zone_id = var.alb_zone_id
    evaluate_target_health = false
  }
  allow_overwrite = false
}

resource "aws_alb_target_group" "target" {
  name = 
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  deregistration_delay = var.deregistration_delay
  
  health_check {
    path = var.health_check_path == "" ? format("/ping/%s", var.app_name) ? var.health_check_path
    healthy_threshold = var.
    unhealthy_threshold = var.
    }
    lifecycle {
      create_before_destroy = true
    }
}
 resource "aws_alb_listener_rule" "listener_http_rule" {
   count = local.http_count
   listener_arn = var.
   priority = var.priority
   
   action {
     type = "forward"
     target_group_arn = var.alb_target_group.target_group.arn
   }
   
   dynamic "condition" {
     for_each = local.path_pattern_iterator
     content {
       path_pattern {
         values = [local.path_pattern]
       }
     }
   }
   
   dynamic "condition" {
     for_each = local.host_header_iterator
     content {
       host_header {
         values = local.host_header
       }
     }
   }
   
   resource "aws_alb_listener_rule" "listener_https_rule" {
     listener_arn = var.
     priority = 
     
     action {
       type = "forward"
       target_group_arn = aws_alb_target_group.target_group.arn
     }
     
   
   
  




