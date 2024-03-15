output "s3_bucket_id" {
  description = "Website endpoint"
  value       = aws_s3_bucket_website_configuration.lab1_website_configuration.website_endpoint
}
