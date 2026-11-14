variable "tenant_id" {
  type = string
}

variable "location" {
  type = string
}

////// secrets //////

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
  ephemeral = true
}

variable "amiasea_tfe_token" {
  type      = string
  sensitive = true
  ephemeral = true
}