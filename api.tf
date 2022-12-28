resource "aws_api_gateway_resource" "api" {
  rest_api_id = 
  parent_id = aws_api_gateway_resource.api.id
  path_part = "upto"
}

