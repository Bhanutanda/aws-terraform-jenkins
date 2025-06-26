########################
# main.tf
########################

# --- Provider ----------------------------------
provider "aws" {
  region = "us-east-2"           # change if you use another region
}

# --- Variables ---------------------------------
variable "bucket_name" {
  description = "Globally-unique S3 bucket name for the static site"
  type        = string
}

# --- S3 Bucket ---------------------------------
resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

# --- Disable “Block Public Access” -------------
resource "aws_s3_bucket_public_access_block" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# --- Public-Read Bucket Policy -----------------
resource "aws_s3_bucket_policy" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadForStaticWebsite"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
}

# --- Static-Website Configuration --------------
resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }
}

# --- Upload index.html -------------------------
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "index.html"
  source       = "${path.module}/../index.html"   # adjust path if needed
  content_type = "text/html"
}

# --- Output the website endpoint --------------
output "website_url" {
  value = aws_s3_bucket_website_configuration.static_site.website_endpoint
}
