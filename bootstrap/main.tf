data "azuread_client_config" "current" {}

module "vault" {
  source = "./modules/vault"

  tenant_id = data.azuread_client_config.current.tenant_id
  location  = var.location

  ps_gallery_api_key          = var.ps_gallery_api_key
  amiasea_webhook_token       = var.amiasea_webhook_token
  amiasea_github_app_pem_file = var.amiasea_github_app_pem_file

  amiasea_tfe_token = var.tfe_token
}

module "aws_artifact_foundation" {
  source = "./modules/aws_artifact_foundation"
}

module "institutive_plane" {
  source = "./modules/institutive_plane"

  tfe_organization_name                       = var.tfe_organization_name
  github_organization_name                    = var.github_organization_name
  github_enterprise_orchard_organization_name = var.github_enterprise_orchard_organization_name
  azure_institutive_resource_group_name       = var.azure_institutive_resource_group_name
  providers = {
    azurerm                   = azurerm
    tfe                       = tfe
    github                    = github
    github.enterprise_orchard = github.enterprise_orchard
  }
}

module "federation_subject_identifiers" {
  source = "./modules/federation_subject_identifiers"

  institutive_repositories = module.institutive_plane.repositories
  topology_repositories    = module.solution_topology.repositories
  orchard_repositories       = module.orchard_plane.repositories

  github_organization_id                    = module.institutive_plane.github_organization_id
  github_enterprise_orchard_organization_id = module.institutive_plane.github_enterprise_orchard_organization_id
}

module "aws_access" {
  source = "./modules/aws_access"

  github_actions_oidc_provider_arn = module.aws_artifact_foundation.github_actions_oidc_provider_arn

  github_subject_identifiers = module.federation_subject_identifiers.aws_orchard_federated_subject_identifiers

  orchard_packages_repository_arn = module.aws_artifact_foundation.orchard_packages_repository_arn
  codeartifact_domain_arn         = module.aws_artifact_foundation.codeartifact_domain_arn
}

module "azure_access" {
  source = "./modules/azure_access"

  azure_institutive_resource_group_name = var.azure_institutive_resource_group_name
  location                              = var.location

  institutive_federated_credential_subject_identifiers = module.federation_subject_identifiers.institutive_federated_credential_subject_identifiers

  topology_federated_credential_subject_identifiers = module.federation_subject_identifiers.topology_federated_credential_subject_identifiers
  fruit_federated_credential_subject_identifiers    = module.federation_subject_identifiers.fruit_federated_credential_subject_identifiers

  institutive_key_vault_id = module.vault.institutive_key_vault_id
}

module "github_actions_variables" {
  source = "./modules/github_actions_variables"

  aws_account_id      = module.aws_artifact_foundation.aws_account_id
  codeartifact_domain = module.aws_artifact_foundation.codeartifact_domain

  github_organization_id = module.institutive_plane.github_organization_id
  gha_id                 = module.institutive_plane.gha_id
  gha_client_id          = var.amiasea_github_app_client_id

  azure_tenant_id                   = data.azuread_client_config.current.tenant_id
  azure_institutive_client_id       = module.azure_access.azure_institutive_client_id
  azure_orchard_client_id           = module.azure_access.azure_orchard_client_id
  azure_institutive_subscription_id = module.institutive_plane.azure_institutive_subscription_id
  tfe_gha_installation_id           = module.institutive_plane.tfe_gha_installation_id

  institutive_key_vault_name = module.vault.institutive_key_vault_name
  institutive_key_vault_uri  = module.vault.institutive_key_vault_uri

  ps_gallery_api_key_versionless_id = module.vault.ps_gallery_api_key_versionless_id

  amiasea_webhook_token_versionless_id = module.vault.amiasea_webhook_token_versionless_id

  amiasea_github_app_pem_file_versionless_id = module.vault.amiasea_github_app_pem_file_versionless_id

  amiasea_tfe_token_versionless_id = module.vault.amiasea_tfe_token_versionless_id

  institutive_repository_ids = module.institutive_plane.repository_ids

  providers = {
    github                    = github
    github.enterprise_orchard = github.enterprise_orchard
  }
}

module "github_repo_props" {
  source = "./modules/github_repo_props"

  providers = {
    github                    = github
    github.enterprise_orchard = github.enterprise_orchard
  }
}

module "solution_topology" {
  source = "./modules/solution_topology"

  solution_topology_template_repo_name = "enterprise-solution-topology"
  solution_topology_release_tag = "v1.0.0"
  providers = {
    github = github
  }
}

module "orchard_plane" {
  source = "./modules/orchard_plane"

  solution_topology = module.solution_topology.solution_topology
  orchard_packages_repository = module.aws_artifact_foundation.orchard_packages_repository
  solution_topology_packages_repository = module.aws_artifact_foundation.solution_topology_packages_repository

  providers = {
    github = github.enterprise_orchard
  }
}
