# creating s3 bucket
resource "aws_s3_bucket" "lab1_bucket" {
  bucket        = "lab1.${local.domain}"
  force_destroy = true
}
# enable versioning
resource "aws_s3_bucket_versioning" "lab1_bucket_versioning" {
  bucket = aws_s3_bucket.lab1_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
# S3 bucket website configuration
resource "aws_s3_bucket_website_configuration" "lab1_website_configuration" {
  depends_on = [aws_s3_bucket.lab1_bucket]
  bucket     = aws_s3_bucket.lab1_bucket.id
  index_document {
    suffix = "index.html"
  }
}
# upload html files to the S3 bucket 
resource "aws_s3_object" "upload_html" {
  for_each     = fileset("test/", "*.html")
  bucket       = aws_s3_bucket.lab1_bucket.id
  key          = each.value
  source       = "test/${each.value}"
  etag         = filemd5("test/${each.value}")
  content_type = "text/html"
}
# upload css files to the S3 bucket 
resource "aws_s3_object" "upload_css" {
  for_each     = fileset("test/", "*.css")
  bucket       = aws_s3_bucket.lab1_bucket.id
  key          = each.value
  source       = "test/${each.value}"
  etag         = filemd5("test/${each.value}")
  content_type = "text/css"
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.lab1_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:*"]
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.lab1_bucket.bucket}/*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
# apply policy to the S3 bucket
resource "aws_s3_bucket_policy" "public_access_policy" {
  depends_on = [
    data.aws_iam_policy_document.s3_policy,
    aws_s3_bucket_public_access_block.public_access
  ]
  bucket = aws_s3_bucket.lab1_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
