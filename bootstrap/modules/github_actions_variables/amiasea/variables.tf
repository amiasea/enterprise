variable "aws_account_id" {
  type = string
}

variable "codeartifact_domain" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

variable "azure_institutive_client_id" {
  type = string
}

variable "azure_institutive_subscription_id" {
  type = string
}

variable "tfe_gha_installation_id" {
  type = string
}

variable "gha_id" {
  type = string
}

variable "github_organization_id" {
  type = string
}

variable "repository_ids" {
  type = set(string)
}

////// secret references //////

variable "institutive_key_vault_name" {
  type = string
}

variable "institutive_key_vault_uri" {
  type = string
}

variable "ps_gallery_api_key_versionless_id" {
  type = string
}

variable "amiasea_webhook_token_versionless_id" {
  type = string
}

variable "amiasea_github_app_pem_file_versionless_id" {
  type = string
}

variable "amiasea_tfe_token_versionless_id" {
  type = string
}