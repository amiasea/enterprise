output "codeartifact_domain" {
  description = "Name of the shared AWS CodeArtifact domain."
  value       = aws_codeartifact_domain.amiasea.domain
}

output "codeartifact_domain_arn" {
  description = "ARN of the shared AWS CodeArtifact domain."
  value       = aws_codeartifact_domain.amiasea.arn
}

output "codeartifact_domain_owner" {
  description = "AWS account ID that owns the CodeArtifact domain."
  value       = aws_codeartifact_domain.amiasea.owner
}

output "github_oidc_provider_arn" {
  description = "ARN of the GitHub Actions OpenID Connect provider."
  value       = aws_iam_openid_connect_provider.github.arn
}

output "hcp_terraform_oidc_provider_arn" {
  description = "ARN of the HCP Terraform OpenID Connect provider."
  value       = aws_iam_openid_connect_provider.hcp_terraform.arn
}

output "aws_account_id" {
  description = "AWS account ID in which the foundation is deployed."
  value       = data.aws_caller_identity.current.account_id
}

output "orchard_packages_repository" {
  description = "The shared CodeArtifact repository for orchard packages."

  value = {
    name = aws_codeartifact_repository.orchard_repository.repository
    arn  = aws_codeartifact_repository.orchard_repository.arn
  }
}

output "solution_topology_packages_repository" {
  description = "The CodeArtifact repository for solution topology packages."

  value = {
    name = aws_codeartifact_repository.solution_topology_repository.repository
    arn  = aws_codeartifact_repository.solution_topology_repository.arn
  }
}