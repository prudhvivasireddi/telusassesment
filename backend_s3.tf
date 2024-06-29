resource "aws_s3_bucket" "bucket" {
  bucket = "telus-assesment-terraform-state-backend"
  tags   = var.tags_all
}

resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_object_lock_configuration" "bucket" {
  bucket              = aws_s3_bucket.bucket.id
  object_lock_enabled = "Enabled"
  depends_on          = [aws_s3_bucket_versioning.bucket] # Adding depends on condition as versioning should be enabled before object lock
}