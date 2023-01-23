locals {
  Env = terraform.workspace == "default" ? "prod" : terraform.workspace
  Environment = terraform.workspace == "default" ? "production" : terraform.workspace == "stg" ? "staging" : "development"
  RegionCode = " "
  common_tags = {
    environment = local.Environment
  }
}

variable "vpc_id" {
  type = map(string) 
  default = {
    "stg" = " "
    "dev" = " "
  }
 variable "subnet_ids" {
   type = map(list(string))
   default = {
     "stg" = [
       " ",
       " "
       ]
     "dev" = [
       " ",
       " "
       ]
   }
 }
 
 variable "security_group_ids" {
   type = map(map(list(string)))
   default = {
     "stg" = {
       "d1" = [
         " "
         ]
     }
     "dev" = {
       "d2" = [
         " "
         }
       ]
   }
 }
}

resource "aws_vpc_endpoint" "r1" {
  vpc_id = var.vpc_id["${local.Env}"]
  service_name = " "
  subnet_ids = var.subnet_ids["${local.Env}"]
  security_group_ids = concat(var.security_group_ids["${local.Env}"]["d1"] , )
  private_dns_enabled = true
  vpc_endpoint_type = "Interface"
  tags = local.common_tags
}

resource "aws_lb_target_group" "group" {
  name = var.name
  port = var.port
  protocol = var.protocol
  vpc_id = var.vpc_id
  target_type = var.target_type
  tags = {
    environment = var.env
  }
  lifecycle {
    create_before_destroy = true
  }
  health_check {
    enabled = var.health_checks_enabled
    path = var.ping_path
    matcher = var.matcher
    protocol = var.protocol
  }
}

resource "aws_lb_target_group_attachment" "a1" {
  for_each = toset(var.targets)
  target_group_arn = aws_lb_target_group.group.arn
  target_id = each.value
  port = var.port
}

module "api_target_group" {
  source = "../../modules/target_group"
  name = "ec2-alb"
  port = 443
  protocol = "HTTPS"
  vpc_id = var.vpc_id["${local.Env}"]
  target_type = "ip"
  env = "staging"
  targets = [ for eni in data.aws_network: eni.private_ip ]
  ping_path = "/ping"
  matcher = "200, 403"     
}  

module "api_alb" {
  source = "../../modules/aws_lb"
  name = "alb-api"
  internal = true
  security_groups = concat(var.security_group_ids["${local.Env}"]["api"])
  subnet_ids = var.subnet_ids["${local.env}"]
  idle_timeout = 300
  access_logs_bucket = " "
  access_logs_prefix = " "
  certificate_arn = data.aws_acm_certificate
  target_group_arn = 
  env = local.Environment
}
 resource "aws_vpc_endpoint" "s3" {
  count = terraform.workspace == "dev" ? 1 : 0
  vpc_id = var.vpc_id["${local.Env}"]
  service_name = " "
  tags = local.common_tags 
}

resource "aws_vpc_endpoint_route_table_association" "s3" {
  for_each = toset(var.s3_endpoint-[local.Env])
  route_table_id = each.key
  vpc_endpoint_id = aws_vpc_endpoint.s3.0.id
}  

resource "aws_lb" "l1" {
  name = var.name
  internal = var.internal
  security_groups = var.security_groups
  subnets = var.subnet_ids
  enable_deletion_protection = true
  idle_timeout = var.idle_timeout
  load_balancer_type = var.lb_type
  access_logs {
    enabled = true
    bucket = 
    prefix = 
  }
  tags = {
    "environment" = var.env
  }
  
  resource "aws_lb_listener" "listener_non" {
    load_balancer_arn = aws_lb.lb.arn
    port = var.port_nonssl
    protocol = var.protocol_non
    default_action {
      type = "redirect" 
      
      redirect {
        port = var.port_ssl
        protocol = var.protocol_ssl
        status = var.status_code_redirect
      }
    }
  }
  
  resource "aws_lb_listener" "list" {
    load_balancer_arn = aws_lb.lb.arn
    port = var.port_ssl
    protocol = var.protocol_ssl
    certificate_arn = var.certificate_arn
    
    default_action {
      target_group_arn = var.target_group_arn
      type = "forward"
    }
  } 
    
      
    
  
  
  
  
  
  
  
  
  





         
     
  
