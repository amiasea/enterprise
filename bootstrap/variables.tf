variable "azure_organization_name" {
  type    = string
  default = "amiasea"
}

variable "aws_organization_name" {
  type    = string
  default = "amiasea"
}

variable "github_organization_name" {
  type = string
  default = "amiasea"
}

variable "github_enterprise_orchard_organization_name" {
  type = string
  default = "amiasea-enterprise-orchard"
}

variable "tfe_organization_name" {
  type    = string
  default = "amiasea"
}

variable "cloudflare_organization_name" {
  type    = string
  default = "amiasea"
}

variable "location" {
  type    = string
  default = "centralus"
}

variable "azure_institutive_resource_group_name" {
  type = string
  default = "amiasea-enterprise-institutive"
}

variable "cloudflare_account_id" {
  type = string
}

variable "amiasea_github_app_installation_id" {
  type      = string
}

variable "enterprise_orchard_github_app_installation_id" {
  type      = string
}

variable "amiasea_github_app_id" {
  type      = string
}

variable "r2_access_key_id" {
  type      = string
  sensitive = true
}

variable "r2_secret_access_key" {
  type      = string
  sensitive = true
}

////// secrets //////

variable "tfe_token" {
  type      = string
  sensitive = true
  ephemeral = true
}

variable "ps_gallery_api_key" {
  type      = string
  sensitive = true
  ephemeral = true
}

variable "amiasea_webhook_token" {
  type      = string
  sensitive = true
  ephemeral = true
}

variable "amiasea_github_app_pem_file" {
  type      = string
  sensitive = true
}