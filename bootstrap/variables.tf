variable "azure_organization_name" {
  type    = string
  default = "amiasea"
}

variable "aws_organization_name" {
  type    = string
  default = "amiasea"
}

variable "tfe_organization_name" {
  type    = string
  default = "amiasea"
}

variable "tfe_development_organization_name" {
  type    = string
  default = "amiasea-development"
}

variable "cloudflare_organization_name" {
  type    = string
  default = "amiasea"
}

variable "location" {
  type    = string
  default = "centralus"
}

variable "cloudflare_account_id" {
  type = string
}

variable "r2_access_key_id" {
  type      = string
  sensitive = true
}

variable "r2_secret_access_key" {
  type      = string
  sensitive = true
}

variable "tfe_token" {
  type      = string
  sensitive = true
}

variable "tfe_development_token" {
  type      = string
  sensitive = true
}
