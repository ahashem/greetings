resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.name
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = var.object_ownership
  }
}

# terraform destroy does not delete the S3 Bucket ACL
# only remove the resource from Terraform state.
resource "aws_s3_bucket_acl" "s3_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket]

  bucket = aws_s3_bucket.s3_bucket.id
  acl    = var.acl
}

resource "aws_s3_bucket_policy" "s3_bucket" {
  count  = length(var.policy) > 0 ? 1 : 0

  bucket = aws_s3_bucket.s3_bucket.id
  policy = var.policy
}

resource "aws_s3_bucket_versioning" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    id = "cleanup"

    expiration {
      days = var.lifecycle_keep_days
    }

    status = var.cleanup_lifecycle
  }

  rule {
    id = "noncurrent_version_cleanup"

    noncurrent_version_expiration {
      noncurrent_days = var.noncurrent_version_lifecycle_keep_days
    }

    status = var.noncurrent_version_lifecycle
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.sse_algorithm == "aws:kms" ? var.kms_key_id: null
      sse_algorithm = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

