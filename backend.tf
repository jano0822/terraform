# create S3 bucket
resource "aws_s3_bucket" "janobucket" {
    bucket = "janos3backend"
}

# S3 bucket object ownership
resource "aws_s3_bucket_ownership_controls" "janobucket" {
  bucket = aws_s3_bucket.janobucket.bucket
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# S3 bucket versioning 
resource "aws_s3_bucket_versioning" "janobucket" {
  bucket = aws_s3_bucket.janobucket.bucket

  versioning_configuration {
    status = "Enabled"
  }

  # only runs after bucket is created
  depends_on = [aws_s3_bucket.janobucket]
}

# S3 bucket server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "janobucketconfig" {
    bucket = aws_s3_bucket.janobucket.bucket

    rule {
        apply_server_side_encryption_by_default {
        kms_master_key_id = "e0b11594-76d4-4705-8465-e91a13e2531f"
        sse_algorithm     = "aws:kms"
        }
    }
}

# create dynamodb
resource "aws_dynamodb_table" "janodynamodb" {
    name = "janostatelock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}