output "github_organization_id" {
  value = data.github_organization.this.id
}

output "github_enterprise_orchard_organization_id" {
  value = data.github_organization.enterprise_orchard.id
}

output "azure_institutive_subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}

output "azure_institutive_resource_group_id" {
  value = data.azurerm_resource_group.amiasea_institutive.id
}

output "gha_id" {
  value = data.github_app.gha.id
}

output "gha_installation_id" {
  value = [
    for app in data.github_organization_app_installations.all.installations : 
    app.id if app.app_slug == data.github_app.gha.slug
  ][0]
}

output "tfe_gha_installation_id" {
  value = data.tfe_github_app_installation.tfe_gha_installation.id
}

output "institutive_repositories" {
  description = "Repositories designated with the institutive custom property."
  value       = local.institutive_repositories
}

output "institutive_repository_ids" {
  description = "GitHub repository IDs designated as institutive."
  value       = local.institutive_repository_ids
}

output "enterprise_repositories" {
  description = "Non-archived repositories in the enterprise- namespace."
  value       = local.enterprise_repositories
}