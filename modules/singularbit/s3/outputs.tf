output "s3_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}
output "s3_domain_name" {
  value = aws_s3_bucket.s3_bucket.bucket_domain_name
}
output "s3_id" {
  value = aws_s3_bucket.s3_bucket.id
}
output "s3_bucket" {
  value = aws_s3_bucket.s3_bucket.bucket
}
output "s3_website_domain" {
  value = aws_s3_bucket.s3_bucket.website_domain #.website_endpoint
}
