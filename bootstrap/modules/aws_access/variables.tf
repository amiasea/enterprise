variable "github_actions_oidc_provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider."
  type        = string
}

variable "github_subject_identifiers" {
  description = "GitHub OIDC subject identifiers permitted to assume the Orchard publisher role."
  type        = list(string)
}

variable "orchard_packages_repository_arn" {
  description = "ARN of the Orchard CodeArtifact repository."
  type        = string
}

variable "codeartifact_domain_arn" {
  description = "ARN of the shared AWS CodeArtifact domain."
  type        = string
}