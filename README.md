# Terraform S3 Static Site Setup

Terraform script to configure S3 and Cloudfront for static website hosting. Restricted access to Cloudfront via referer header, custom domain, and so on.

## Requirements

- [Terraform](https://learn.hashicorp.com/terraform/getting-started/install)
- AWS Account

## Usage

1. `terraform init`
1. `cp environment.tfvars.example environment.tfvars` and change as needed (see _Settings_ section)
1. Verify: `terraform plan -var-file=environment.tfvars`
1. Invoke: `terraform apply -var-file=environment.tfvars`

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
