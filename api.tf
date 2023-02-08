resource "aws_api_gateway_resource" "api" {
  rest_api_id = 
  parent_id = aws_api_gateway_resource.api.id
  path_part = "upto"
}

resource "aws_api_gateway_rest_api" "m1" {
  name = 
  endpoint_configuration {
    types = ["PRIVATE"]
    vpc_endpoint_ids = 
  }
  tags = {
    "environment": local.Environment
  }
}

resource "aws_api_gateway_rest_api_policy" "m2" {
  rest_api_id = aws_api_gateway_rest_api.m1.id
  policy = templatefile("${path.module}", { VpcIds = , ApiId = , } )
}

resource "aws_api_gateway_method_settings" "m3" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name = 
  method_path = "*/*"
  
  settings {
    metrics_enabled = true
    logging_level = "INFO"
  }
}

data "aws_acm_certificate" "t1" {
  domain = "oma.onemain.financial"
}

resource "aws_api_gateway_domain_name" "s1" {
  for_each = 
  domain_name = each.key
  regional_certificate_arn = 
  
  endpoint_configuration {
    types = each.value["endpoint_types"]
  }
  
  tags = {
    "environment": local.Environment
  }
}

resource "aws_api_gateway_base_path_mapping" "s1" {
  domain_name = each.key
}

resource "aws_api_gateway_method" "b1" {
}






  
resource "aws_api_gateway_deployment" "a1" {
  depends_on = 
  rest_api_id = 
  lifecycle {
    create_before_destroy = true 
  }
  triggers = {
    redeployment = join("", [ for file in fileset(path.module, "**.tf"): filesha1(file)
      ])
      }
    variables = {
      deployed_at = timestamp()
    }
    resource "aws_api_gateway_stage" "b1" {
      rest_api_id = 
      deployment_id = 
      stage_name = "b1"
      cache_cluster_enabled = false
      cache_cluster_size = "0.5"
      
      access_log_settings {
        destination_arn = 
        format = 
      }
    }
    
    
    
