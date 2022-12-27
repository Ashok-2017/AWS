resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "s3.amazonaws.com"
resource "aws_cloudfront_distribution" "redirection_distribution" {
  enabled = true
  aliases = ["www.google.com", "www.github.com"]
  origin {
    domain_name = "aws_s3-bucket"
    origin_id = "www.google.com"
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }
  default_cache_behaviour {
    allowed_methods = ["HEAD", "GET", "OPTIONS"]
    cached_methods = ["HEAD", "GET", "OPTIONS"]
    target_origin_id = "www.google.com"
    forwarded_values {
      query_string = var.forward_query_string
      cookies {
        forward = var.forward_cookies
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }
  restrictions {
    geo_restriction {
        restriction_type = "none"
    }
  }
  iewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    minimum_protocol_version = "TLSv1"
    ssl_support_method       = "sni-only"
  }

  logging_config {
    bucket          = "s3.amazonaws.com"
    prefix          = "www.github.com"
  }
}
  
