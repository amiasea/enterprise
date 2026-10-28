data "aws_caller_identity" "current" {}

resource "aws_codeartifact_domain" "amiasea" {
  domain = "amiasea"
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  # GitHub Actions OIDC provider thumbprints are managed by AWS
  # for this well-known provider.
  thumbprint_list = []
}