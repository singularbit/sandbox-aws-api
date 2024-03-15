variable "custom_tags" {
  description = "Custom tags to apply to all resources"
  type        = map(any)
  default     = {}
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
}
variable "use_bucket_server_side_encryption_configuration" {
  description = "Use Server Side Encryption Configuration"
  type        = bool
  default     = true
}
variable "encryption_algorithm" {
  description = "The encryption algorithm to use"
  type        = string
  default     = "AES256"
}
variable "set_bucket_acl_private" {
  description = "Set the bucket ACL to private"
  type        = bool
  default     = true
}
variable "set_bucket_versioning_enabled" {
  description = "Set the bucket versioning to enabled"
  type        = bool
  default     = true
}
variable "set_bucket_policy_access_block" {
  description = "Set the bucket policy to block public access"
  type        = bool
  default     = true
}
variable "set_s3_bucket_website_configuration" {
  description = "The website configuration for the S3 bucket"
  type        = bool
  default     = false
}
variable "website_index_document" {
  description = "The index document for the S3 bucket"
  type        = string
  default     = "index.html"
}
variable "website_error_document" {
  description = "The error document for the S3 bucket"
  type        = string
  default     = "error.html"
}

variable "set_bucket_ownership_controls" {
  description = "Set the bucket ownership controls"
  type        = bool
  default     = true
}
variable "object_ownership" {
  description = "The object ownership"
  type        = string
  default     = "BucketOwnerPreferred"
}

variable "set_s3_bucket_policy" {
  description = "Set the S3 bucket policy"
  type        = bool
  default     = false
}
variable "s3_bucket_policy_file" {
  description = "The S3 bucket policy file"
  type        = string
  default     = ""
}
variable "cdn_oai_iam_arn" {
  description = "The ARN of the CloudFront OAI to associate with the bucket policy"
  type        = string
  default     = ""
}