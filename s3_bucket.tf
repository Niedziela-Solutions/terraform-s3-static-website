resource "aws_s3_bucket" "static" {
  bucket = var.s3_bucket
  acl = "private"

  website {
    index_document = "index.html"
  }

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
