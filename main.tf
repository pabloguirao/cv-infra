resource "aws_s3_bucket" "cv" {
    bucket = var.bucket_name

    tags = {
        Name = "cv-pabloguirao"
        Project = "cv-infra"
    }
}

resource "aws_s3_bucket_public_access_block" "cv" {
  bucket = aws_s3_bucket.cv.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "cv" {
  bucket = aws_s3_bucket.cv.id
  versioning_configuration {
    status = "Disabled"
  }
}