resource "aws_s3_bucket" "this" {
  bucket = "my-terraform-bucket-841226"
  force_destroy = true

  tags = {
    Name = "MyBucket"
  }
}

# (Optional) Enable bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# (Optional) Block all public access
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
