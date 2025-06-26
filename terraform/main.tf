provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  tags = {
    Name = "StaticSiteBucket"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "index.html"
  source = "${path.module}/../index.html"
  content_type = "text/html"
  acl    = "public-read"
}

output "website_url" {
  value = aws_s3_bucket.static_site.website_endpoint
}