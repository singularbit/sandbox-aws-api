resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  tags   = var.custom_tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_server_side_encryption_configuration" {
  count = (var.use_bucket_server_side_encryption_configuration == true) ? 1 : 0

  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms" # AES256, aws:kms, aws:kms:dsse
    }
  }

}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership_controls" {
  count = (var.set_bucket_ownership_controls == true) ? 1 : 0

  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    object_ownership = var.object_ownership
  }

}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  count = (var.set_bucket_acl_private == true) ? 1 : 0

  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_ownership_controls]

  bucket = aws_s3_bucket.s3_bucket.id

  acl = "private"

}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  count = (var.set_bucket_versioning_enabled == true) ? 1 : 0

  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }

}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  count = (var.set_bucket_policy_access_block == true) ? 1 : 0

  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_website_configuration" "s3_bucket_website_configuration" {
  count = (var.set_s3_bucket_website_configuration == true) ? 1 : 0

  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = var.website_index_document
  }

  error_document {
    key = var.website_error_document
  }
}

# Define your own policy for the bucket
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  count  = (var.set_s3_bucket_policy == true) ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id

  policy = templatefile("${path.module}/bucket_policies/${var.s3_bucket_policy_file}",
    {
      s3_bucket_arn  = aws_s3_bucket.s3_bucket.arn
      cloudfront_oai = var.cdn_oai_iam_arn
    })
}