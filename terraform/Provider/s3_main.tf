provider "aws" {
  region = var.region_1
  alias  = "region_1"  # First provider (us-west-1)
}

provider "aws" {
  region = var.region_2
  alias  ="region_2"  # Second provider (us-east-1)
}
resource "random_id" "random_hex_1" {
  byte_length = 8
}

resource "random_id" "random_hex_2" {
  byte_length = 8
}

# First S3 Bucket in region 1 (us-west-1)
resource "aws_s3_bucket" "bucket_1" {
  provider = aws.region_1  # Use the first provider (us-west-1)
  bucket   = format("%s-%s", var.bucket_name_1, random_id.random_hex_1.hex)
  
  tags = {
    Name        = var.Bucket_1
    Environment = "Dev"
  }
lifecycle {
    prevent_destroy = true  # This will prevent the bucket from being destroyed
  }
  
}

# Second S3 Bucket in region 2 (us-east-1)
resource "aws_s3_bucket" "bucket_2" {
  provider = aws.region_2  # Use the second provider (us-east-1)
  bucket   = format("%s-%s", var.bucket_name_2, random_id.random_hex_2.hex)
  
  tags = {
    Name        = var.Bucket_2
    Environment = "Prod"
  }
}
# we can not define variable inside s3 bucket, if we want i default location we need to specify in provider 
# in case if we want to create in two s3 buckets in different location we need to use 
# alias and providers.

terraform apply --auto-approve -var-file="s3_variable.tfvars" -target="aws_s3_bucket.bucket_2"


