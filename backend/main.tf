provider "aws" {
  region = "us-west-2"
}

# Try to fetch existing resources
data "aws_s3_bucket" "existing_state" {
  bucket = "terraform-module-infra-state"
}

data "aws_dynamodb_table" "existing_locks" {
  name = "terraform-locks"
}

# Local variables to determine if resources exist
locals {
  s3_exists = can(data.aws_s3_bucket.existing_state.id)
  dynamodb_exists = can(data.aws_dynamodb_table.existing_locks.id)
}

# Create S3 bucket if it doesn't exist
resource "aws_s3_bucket" "terraform_state" {
  count  = local.s3_exists ? 0 : 1
  bucket = "terraform-module-infra-state"

  lifecycle {
    prevent_destroy = true
  }
}

# Configure versioning regardless of whether bucket is new or existing
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = local.s3_exists ? data.aws_s3_bucket.existing_state.id : aws_s3_bucket.terraform_state[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

# Configure encryption regardless of whether bucket is new or existing
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = local.s3_exists ? data.aws_s3_bucket.existing_state.id : aws_s3_bucket.terraform_state[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Create DynamoDB table if it doesn't exist
resource "aws_dynamodb_table" "terraform_locks" {
  count        = local.dynamodb_exists ? 0 : 1
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
