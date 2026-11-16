variable "institutive_repositories" {
  description = "Institutive GitHub repositories eligible for federated subject identifier construction."
  type = map(object({
    name          = string
    repository_id = number
  }))
}

variable "topology_repositories" {
  description = "Orchard GitHub topology repositories eligible for federated subject identifier construction."
  type = map(object({
    name          = string
    repository_id = number
  }))
  default = {}
}

variable "orchard_repositories" {
  description = "Orchard GitHub fruit repositories eligible for federated subject identifier construction."
  type = map(object({
    name          = string
    repository_id = number
  }))
  default = {}
}

variable "github_organization_name" {
  type = string
  default = "amiasea"
}

variable "github_organization_id" {
  type = string
}

variable "github_enterprise_orchard_organization_name" {
  type = string
  default = "amiasea-enterprise-orchard"
}

variable "github_enterprise_orchard_organization_id" {
  type = string
}