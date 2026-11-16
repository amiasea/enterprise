data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "amiasea_institutive" {
  name = var.azure_institutive_resource_group_name
}

data "tfe_github_app_installation" "tfe_gha_installation" {
  name = var.tfe_organization_name
}

data "github_organization" "this" {
  name = var.github_organization_name
}

data "github_organization" "enterprise_orchard" {
  provider = github.enterprise_orchard

  name = var.github_enterprise_orchard_organization_name
}

data "github_app" "gha" {
  slug = var.github_organization_name
}

data "github_organization_app_installations" "all" {}

data "github_repositories" "institutive_repositories" {
  query = "org:amiasea archived:false"
  include_repo_id = true
}

data "github_repository_custom_properties" "institutive" {
  for_each = toset(data.github_repositories.institutive_repositories.names)

  repository = each.value
}