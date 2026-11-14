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

module "terraform_stacks" {
  source = "./modules/terraform_stacks"

  tfe_token = var.tfe_token

  tfe_gha_installation_id = module.institutive_plane.tfe_gha_installation_id

  tfe_organization_name = var.tfe_organization_name

  tfe_project = data.tfe_project.institutive

  azure_institutive_resource_group_name = var.azure_institutive_resource_group_name

  codeartifact_domain = module.aws_artifact_foundation.codeartifact_domain

  codeartifact_domain_arn = module.aws_artifact_foundation.codeartifact_domain_arn

  codeartifact_domain_owner = module.aws_artifact_foundation.codeartifact_domain_owner

  pomology_propagation_role_arn = module.aws_access.pomology_propagation_role_arn

  pomology_artifact_role_boundary_arn = module.aws_access.pomology_artifact_role_boundary_arn

  github_oidc_provider_arn = module.aws_artifact_foundation.github_oidc_provider_arn

  github_organization_name = var.github_organization_name

  azure_tenant_id                   = data.azuread_client_config.current.tenant_id
  azure_orchard_client_id           = module.azure_access.azure_orchard_client_id
  azure_institutive_subscription_id = module.institutive_plane.azure_institutive_subscription_id

  gha_id                                 = var.amiasea_github_app_id
  gha_installation_id                    = var.amiasea_github_app_installation_id
  enterprise_orchard_gha_installation_id = var.enterprise_orchard_github_app_installation_id
  gha_pem_file                           = var.amiasea_github_app_pem_file
}

module "terraform_modules" {
  source = "./modules/terraform_modules"

  tfe_organization_name = var.tfe_organization_name

  tfe_gha_installation_id = module.institutive_plane.tfe_gha_installation_id

  gha_id              = var.amiasea_github_app_id
  gha_installation_id = var.enterprise_orchard_github_app_installation_id
  gha_pem_file        = var.amiasea_github_app_pem_file
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

module "aws_access" {
  source = "./modules/aws_access"

  hcp_terraform_oidc_provider_arn = module.aws_artifact_foundation.hcp_terraform_oidc_provider_arn

  pomology_propagation_stack_subject_identifiers = [
    for stack in module.terraform_stacks.stack_subject_identifiers :
    stack.subject_identifier
  ]
}

locals {
  institutive_federated_credential_subject_identifiers = toset([
    for repository in values(module.institutive_plane.enterprise_repositories) :
    "repo:${var.github_organization_name}@${module.institutive_plane.github_organization_id}/${repository.name}@${repository.repository_id}:ref:refs/heads/main"
  ])
}

module "azure_access" {
  source = "./modules/azure_access"

  azure_institutive_resource_group_name = var.azure_institutive_resource_group_name
  azure_institutive_resource_group_id   = module.institutive_plane.azure_institutive_resource_group_id
  location                              = var.location

  institutive_federated_credential_subject_identifiers = local.institutive_federated_credential_subject_identifiers

  institutive_key_vault_id = module.vault.institutive_key_vault_id

  tfe_institutive_project_name = data.tfe_project.institutive.name

  tfe_pomology_propagation_stack_name = module.terraform_stacks.pomology_propagation_stack_name
}

module "github_actions_variables" {
  source = "./modules/github_actions_variables"

  aws_account_id      = module.aws_artifact_foundation.aws_account_id
  codeartifact_domain = module.aws_artifact_foundation.codeartifact_domain

  github_organization_id = module.institutive_plane.github_organization_id
  gha_id                 = module.institutive_plane.gha_id

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

  pomology_propagation_stack_id = module.terraform_stacks.pomology_propagation_stack_id
  pomology_pruning_stack_id     = module.terraform_stacks.pomology_pruning_stack_id

  institutive_repository_ids = module.institutive_plane.institutive_repository_ids

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
