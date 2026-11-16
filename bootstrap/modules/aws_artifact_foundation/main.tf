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

resource "aws_iam_openid_connect_provider" "hcp_terraform" {
  url = "https://app.terraform.io"

  client_id_list = [
    "aws.workload.identity"
  ]
}

resource "aws_codeartifact_repository" "orchard_repository" {
  repository = "orchard"
  domain     = aws_codeartifact_domain.amiasea.domain

  description = "Shared, unrestricted repository for Amiasea orchard packages."

  external_connections {
    external_connection_name = "public:nuget-org"
  }
}

resource "aws_codeartifact_repository" "solution_topology_repository" {
  repository = "solution_topology"
  domain     = aws_codeartifact_domain.amiasea.domain

  description = "Repository for Amiasea solution topology that orchard packages are admitted into."
}