variable "tfe_organization_name" {
  type    = string
  default = "amiasea"
}

variable "github_organization_name" {
  type    = string
  default = "amiasea"
}

variable "codeartifact_domain" {
  type    = string
  default = "amiasea"
}

variable "codeartifact_domain_arn" {
  type    = string
  default = "amiasea"
}

variable "codeartifact_domain_owner" {
  type    = string
  default = "amiasea"
}

variable "pomology_propagation_role_arn" {
  type    = string
}

variable "pomology_artifact_role_boundary_arn" {
  type    = string
}

variable "github_oidc_provider_arn" {
  type    = string
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

variable "azure_tenant_id" {
  type = string
}

variable "azure_orchard_client_id" {
  type = string
}

variable "azure_institutive_subscription_id" {
  type = string
}

variable "gha_id" {
  type      = string
}

variable "gha_installation_id" {
  type      = string
}

variable "enterprise_orchard_gha_installation_id" {
  type      = string
}

variable "gha_pem_file" {
  type      = string
  sensitive = true
}

variable "azure_institutive_resource_group_name" {
  type = string
}