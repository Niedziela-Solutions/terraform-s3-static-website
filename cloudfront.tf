resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled = true
  price_class = "PriceClass_100"
  retain_on_delete = true
  is_ipv6_enabled = true
  comment = "Made by Terraform"
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.static.website_endpoint
    origin_id   = var.s3_origin_id

    custom_header {
      name = "Referer"
      value = "cloudfront-${var.s3_origin_id}"
    }

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.1", "TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_origin_id
    viewer_protocol_policy = "allow-all"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
