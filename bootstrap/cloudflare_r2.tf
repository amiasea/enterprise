resource "cloudflare_r2_bucket" "enterprise" {
  account_id = var.cloudflare_account_id
  name       = "amiasea-enterprise"
  location   = "WNAM"

}

resource "aws_s3_object" "solution_pomologies" {
  provider     = aws.r2
  bucket       = cloudflare_r2_bucket.enterprise.name
  key          = "solution-pomologies/"
  content      = ""
  content_type = "application/x-directory"
}
