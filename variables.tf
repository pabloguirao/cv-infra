variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-south-2"
  
}
variable "bucket_name" {
  description = "Name of the S3 bucket."
  type        = string
  default     = "cv-pabloguirao"
  
}

variable "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  type        = string
  default     = "E26JZHHOLRQL3L"
}