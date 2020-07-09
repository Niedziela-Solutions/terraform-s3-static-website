variable "region" {
  default = "us-east-2"
}

variable "profile" {
  default = "default"
}

variable "s3_bucket" {}

variable "s3_origin_id" {}

variable "aliases" {
  default = []
}

variable "acm_certificate_arn" {}
