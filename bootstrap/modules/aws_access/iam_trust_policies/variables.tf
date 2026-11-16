variable "github_actions_oidc_provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider."
  type        = string
}

variable "github_subject_identifiers" {
  description = "GitHub OIDC subject identifiers permitted to assume the execution role."
  type        = list(string)
  default     = []
}