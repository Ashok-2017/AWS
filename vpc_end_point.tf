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

resource "
  
  





         
     
  
