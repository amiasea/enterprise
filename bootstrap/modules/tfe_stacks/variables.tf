variable "tfe_organization_name" {
  type    = string
  default = "amiasea-development"
}

variable "tfe_token" {
  type      = string
  sensitive = true
}

variable "stack_tags_regex" {
  type    = string
  default = "^v\\d+\\.\\d+\\.\\d+$"
}

variable "tfe_github_app_installation_id" {
  type    = string
}

variable "tfe_project" {
  type = object({
    id = string,
    name = string
  })
}