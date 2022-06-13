resource "aws_s3_bucket" "static" {
  bucket = var.s3_bucket
}

resource "aws_s3_bucket_server_side_encryption_configuration" "static" {
  bucket = aws_s3_bucket.static.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_website_configuration" "static" {
  bucket = aws_s3_bucket.static.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_acl" "static" {
  bucket = aws_s3_bucket.static.id
  acl    = "private"
}


resource "aws_s3_bucket_policy" "static" {
  bucket = aws_s3_bucket.static.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Cloudfront only access policy",
    "Statement": [
        {
            "Sid": "Allow get requests from CF referer",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.s3_bucket}/*",
            "Condition": {
                "StringEquals": {
                    "aws:Referer": "cloudfront-${var.s3_origin_id}"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "static" {
  bucket = aws_s3_bucket.static.id

  block_public_acls   = true
  ignore_public_acls  = true
}
