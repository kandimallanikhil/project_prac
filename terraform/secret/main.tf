main.tf :
--------------------------------------------
provider "aws" {
  region = var.aws_region
}
data "aws_secretsmanager_secret_version" "bucket_name_secret" {
  secret_id = "arn:aws:secretsmanager:eu-north-1:339712844630:secret:sec_name-GQGYjl"  # Replace with your actual secret name or ARN
}
locals {
  secret_data = jsondecode(data.aws_secretsmanager_secret_version.bucket_name_secret.secret_string)
}

resource "aws_s3_bucket" "example" {
  bucket = local.secret_data.bucket_name
  # acl    = var.acl

  tags = {
    Name        = "nikhl"
  }
}
---------------------------------------------------------------------------
variable "aws_region" {
  default = "eu-north-1"
}



