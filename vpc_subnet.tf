resource "aws_subnet" "waf" {
  vpc_id = var.aws_vpc_dev
  cidr_block = " "
  availability_zone = " "
  tags = {
    Name = "waf-a"
  }
}

resource "aws_subnet" "f-a" {
  vpc_id = var.aws_vpc_dev
  cidr_block = " "
  availability_zone = " "
  tags = {
    Name = "f-a"
    "kubernetes.io/role/internal-elb" = 1
  }
}

locals {
  tgws = [
    {
      tarnsit_gateway_id = var.transit_gateway_id
      cidr_block = var.
      }
    ]
}

module "n1" {
  source = "../../naming"
}
  variable "env_name" {}
  variable "public_subnets" {}
  
  resource "aws_eip" "nat" {
    for_each = var.public_subnets
    vpc = true
    lifecycle {
      create_before_destroy = true }
    tags = {
      Name = "${module.ns}-eip"
      zone = each.value.tags.zone
      subnet_name = each.value.tags.Name
      subnet_id = each.value.id
      environment = var.env_name
    }
  }
  resource "aws_nat_gateway" "nat" {
    for_each = aws_eip.nat
    allocation_id = each.value.id
    subnet_id = each.value.tags.subnet_id
    
    tags = {
      Name = "${module.ns}-eip"
      zone = each.value.tags.zone
      subnet_name = each.value.tags.Name
      subnet_id = each.value.id
      environment = var.env_name
    }
  }
  
  module "ns" {
    source = "../../"
  }
  
  variable "env_name" {}
  variable "vpc_id" {}
  
  resource "aws_internet_gateway" "igw" {
    vpc_id = var.vpc_id
    tags = {
      Name = " "
      environment = var.env_name
    }
  }
  
   module "ns" {
     source = "../../"
   }
   variable "transit" {
     type = list(map(string))
     default = []
   }
   resource "aws_subnet" "subnet_protect" {
     for_each = var.subnet
     vpc_id = var.vpc_id
     cidr_block = each.value["cidr"]
     availability_zone = each.value["az"]
     tags = {
       Name = " "
       zone = " "
       usage = each.value["usage"]
       access = each.value["access"]
     }
     resource "aws_route_table" "public" {
       for_each = 
       vpc_id = 
       route {
         cidr_block = " "
         nat_gateway_id = each.value.id
       }
       dynamic "route" {
         content {
           cidr_block = route.vlaue["cidr_block"]
           transit_gateway_id = route.value[""]
         }
       }
       
       resource "aws_vpn_gateway" "vgw" {
         vpc_id = var.vpc_id
         amazon_side_asn = 
         tags = {
           Name = " "
         }
       }
       
       resource "aws_route_table_association" "p1" {
         for_each = 
         subnet_id = each.value
         route_table_id = 
         lifecycle {
           create_before_destroy = false
         }
        
        resource " 
         
         
         
         
         
         
         
         
       
       
       
       
       
     
     
     
     
     
     
     
    
    
  
      
  
  
  


  
