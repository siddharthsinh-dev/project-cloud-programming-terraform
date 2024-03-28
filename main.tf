# Define an AWS S3 bucket named "site-origin-siddharthsinhcodebucket" with environment tag set to "task"

resource "aws_s3_bucket" "site_origin" {
  bucket = "site-origin-siddharthsinhcodebucket"
  tags = {
    environment = "task"
  }
}

# Configure public access settings for the S3 bucket

resource "aws_s3_bucket_public_access_block" "site_origin" {
  bucket = aws_s3_bucket.site_origin.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#Define a policy allowing public read access to objects in the S3 bucket

resource "aws_s3_bucket_policy" "site_origin_policy" {
  bucket = aws_s3_bucket.site_origin.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.site_origin.arn}/*" 
      }
    ]
  })
}

# Configure server-side encryption for the S3 bucket using AES256 encryption algorithm

resource "aws_s3_bucket_server_side_encryption_configuration" "site_origin" {
  bucket = aws_s3_bucket.site_origin.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Enable versioning for the S3 bucket

resource "aws_s3_bucket_versioning" "site_origin" {
  bucket = aws_s3_bucket.site_origin.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Upload the "index.html" file to the S3 bucket as the default root object

resource "aws_s3_object" "content" {
  depends_on = [
    aws_s3_bucket.site_origin
  ]
  bucket = aws_s3_bucket.site_origin.id
  key = "index.html"
  source = "./index.html"
  server_side_encryption = "AES256"
  content_type = "text/html"
}

# Define an origin access identity for CloudFront to restrict access to the S3 bucket

resource "aws_cloudfront_origin_access_identity" "site_access" {
  comment = "Access identity for CloudFront distribution serving static website content from S3 bucket"
}

# Create a CloudFront distribution for content delivery, pointing to the S3 bucket as the origin

resource "aws_cloudfront_distribution" "site_access" {
  depends_on = [
    aws_s3_bucket.site_origin,
    aws_cloudfront_origin_access_identity.site_access
  ]
  enabled = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.site_origin.arn
    viewer_protocol_policy = "https-only"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  origin {
    domain_name = aws_s3_bucket.site_origin.bucket_regional_domain_name
    origin_id = aws_s3_bucket.site_origin.arn
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.site_access.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# Define an IAM policy document to allow access to the S3 bucket resources with specific conditions

data "aws_iam_policy_document" "site_origin" {
  depends_on = [
    aws_cloudfront_distribution.site_access,
    aws_s3_bucket.site_origin
  ]

  statement {
    sid       = "3"
    effect    = "Allow"
    actions   = ["s3:GetObject"]

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }

    resources = [
      aws_s3_bucket.site_origin.arn
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:Referer"
      values   = [aws_cloudfront_distribution.site_access.arn]
    }
  }
}

