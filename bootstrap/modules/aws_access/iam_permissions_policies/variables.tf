variable "role_name" {
  description = "Name of the IAM role receiving this inline policy."
  type        = string
}

variable "orchard_packages_repository_arn" {
  description = "ARN of the Orchard CodeArtifact repository."
  type        = string
}

variable "codeartifact_domain_arn" {
  description = "ARN of the shared AWS CodeArtifact domain."
  type        = string
}