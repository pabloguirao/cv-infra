//S3
resource "aws_s3_bucket" "cv" {
  bucket = var.bucket_name

  tags = {
    Name    = "cv-pabloguirao"
    Project = "cv-infra"
  }
}

resource "aws_s3_bucket_public_access_block" "cv" {
  bucket = aws_s3_bucket.cv.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "cv" {
  bucket = aws_s3_bucket.cv.id
  versioning_configuration {
    status = "Disabled"
  }
}

//CLOUDFRONT

resource "aws_cloudfront_origin_access_control" "cv" {
  name                              = "cv-pabloguirao-oac"
  description                       = "OAC para el bucket S3 del CV"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cv" {
  enabled             = true
  default_root_object = "index.html"
  comment             = "Distribucion CloudFront para cv-pabloguirao"

  origin {
    domain_name              = aws_s3_bucket.cv.bucket_regional_domain_name
    origin_id                = "S3-cv-pabloguirao"
    origin_access_control_id = aws_cloudfront_origin_access_control.cv.id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-cv-pabloguirao"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name    = "cv-pabloguirao-cf"
    Project = "cv-infra"
  }
}

resource "aws_s3_bucket_policy" "cv" {
  bucket = aws_s3_bucket.cv.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontAccess"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.cv.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.cv.arn
          }
        }
      }
    ]
  })
}