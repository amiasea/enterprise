module "amiasea" {
  source = "./amiasea"

  aws_account_id                    = var.aws_account_id
  codeartifact_domain               = var.codeartifact_domain
  azure_tenant_id                   = var.azure_tenant_id
  azure_institutive_client_id       = var.azure_institutive_client_id
  azure_institutive_subscription_id = var.azure_institutive_subscription_id
  tfe_gha_installation_id           = var.tfe_gha_installation_id
  gha_id                            = var.gha_id
  pomology_propagation_stack_id     = var.pomology_propagation_stack_id
  pomology_pruning_stack_id         = var.pomology_pruning_stack_id
  github_organization_id            = var.github_organization_id
  repository_ids                    = var.institutive_repository_ids

  institutive_key_vault_name                 = var.institutive_key_vault_name
  institutive_key_vault_uri                  = var.institutive_key_vault_uri
  ps_gallery_api_key_versionless_id          = var.ps_gallery_api_key_versionless_id
  amiasea_webhook_token_versionless_id       = var.amiasea_webhook_token_versionless_id
  amiasea_github_app_pem_file_versionless_id = var.amiasea_github_app_pem_file_versionless_id
  amiasea_tfe_token_versionless_id           = var.amiasea_tfe_token_versionless_id
}

module "amiasea_enterprise_orchard" {
  source = "./amiasea_enterprise_orchard"

  aws_account_id                    = var.aws_account_id
  codeartifact_domain               = var.codeartifact_domain
  azure_tenant_id                   = var.azure_tenant_id
  azure_orchard_client_id           = var.azure_orchard_client_id
  azure_institutive_subscription_id = var.azure_institutive_subscription_id
  tfe_gha_installation_id           = var.tfe_gha_installation_id
  gha_id                            = var.gha_id
  pomology_propagation_stack_id     = var.pomology_propagation_stack_id
  github_organization_id            = var.github_organization_id

  institutive_key_vault_name                 = var.institutive_key_vault_name
  institutive_key_vault_uri                  = var.institutive_key_vault_uri
  ps_gallery_api_key_versionless_id          = var.ps_gallery_api_key_versionless_id
  amiasea_webhook_token_versionless_id       = var.amiasea_webhook_token_versionless_id
  amiasea_github_app_pem_file_versionless_id = var.amiasea_github_app_pem_file_versionless_id
  amiasea_tfe_token_versionless_id           = var.amiasea_tfe_token_versionless_id

  providers = {
    github = github.enterprise_orchard
  }
}
