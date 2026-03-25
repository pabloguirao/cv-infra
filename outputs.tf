output "bucket_name" {
  description = "Nombre del bucket S3 creado"
  value       = aws_s3_bucket.cv.id
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.cv.arn
}

output "bucket_regional_domain_name" {
  description = "Domain name del bucket, necesario para CloudFront"
  value       = aws_s3_bucket.cv.bucket_regional_domain_name
}