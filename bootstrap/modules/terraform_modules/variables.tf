variable "tfe_organization_name" {
  description = "TFE organization name"
  type = string
}

variable "tfe_gha_installation_id" {
  description = "TFE GitHub App Installation ID"
  type = string
}

variable "gha_installation_id" {
  type      = string
}

variable "gha_id" {
  type      = string
}

variable "gha_pem_file" {
  type      = string
  sensitive = true
  ephemeral = true
}