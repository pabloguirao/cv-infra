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

variable "domain_name" {
  description = "DNS"
  type        = string
  default     = "guiraocloud.com"
  
}

variable "www_domain_name" {
  description = "DNS with www"
  type        = string
  default     = "www.guiraocloud.com"
  
}