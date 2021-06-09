# Terraform S3 Static Site Setup

Terraform script to configure S3 and Cloudfront for static website hosting. Restricted access to Cloudfront via referer header, custom domain, 404 page routing, and so on.

[Niedziela Solutions, LLC's website was made by and is managed using this tool!](https://www.niedzielasolutions.com)

## Requirements

- [Terraform](https://learn.hashicorp.com/terraform/getting-started/install)
- AWS Account
- S3 Bucket with server-side encryption enabled. This is to [store the Terraform state remotely](https://www.terraform.io/docs/language/state/remote.html) in [an S3 Bucket](https://www.terraform.io/docs/language/settings/backends/s3.html).
- A website you want to setup infrastructure for!

## Usage

1. `terraform init -backend-config="profile=YOUR_AWS_PROFILE"`. It will prompt for the S3 Bucket you want to use to store your Terraform state and the AWS region to use.
1. `cp environment.tfvars.example environment.tfvars` and change as needed (see _Settings_ section)
1. Verify: `terraform plan -var-file=environment.tfvars`
1. Invoke: `terraform apply -var-file=environment.tfvars`

## Need to import existing resources?

1. Import S3 Bucket: `terraform import -var-file=environment.tfvars aws_s3_bucket.static BUCKET_NAME`
1. Import Cloudfront Distribution: `terraform import -var-file=environment.tfvars aws_cloudfront_distribution.s3_distribution CLOUDFRONT_ID`

### Other commands

- Destroy: `terraform destroy -var-file=environment.tfvars`

## Settings

```
region = AWS_REGION
profile = AWS_PROFILE
s3_bucket = BUCKET_NAME_YOU_WANT
s3_origin_id = BUCKET_ORIGIN_ID (also used for referer header)
aliases = LIST_OF_DOMAINS
acm_certificate_arn = ACM CERTIFICATE ARN
viewer_protocol_policy = VIEWER_PROTOCOL_POLICY
```
