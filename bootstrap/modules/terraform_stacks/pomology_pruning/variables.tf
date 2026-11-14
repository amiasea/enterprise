variable "tfe_organization_name" {
  type    = string
  default = "amiasea"
}

variable "github_organization_name" {
  type    = string
  default = "amiasea"
}

variable "tf_token" {
  type      = string
  sensitive = true
  ephemeral = true
}

variable "tfe_gha_installation_id" {
  type    = string
}

variable "tfe_project" {
  type = object({
    id = string,
    name = string
  })
}

variable "gha_id" {
  type      = string
}

variable "gha_installation_id" {
  type      = string
}

variable "gha_pem_file" {
  type      = string
  sensitive = true
}