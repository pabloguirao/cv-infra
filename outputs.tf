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

output "cloudfront_domain_name" {
  description = "URL publica del CV en CloudFront"
  value       = aws_cloudfront_distribution.cv.domain_name
}

output "cloudfront_distribution_id" {
  description = "ID de la distribucion CloudFront, necesario para invalidar cache"
  value       = aws_cloudfront_distribution.cv.id
}

output "acm_certificate_validation_records" {
  description = "Registros DNS para validar el certificado en Namecheap"
  value       = aws_acm_certificate.cv.domain_validation_options
}