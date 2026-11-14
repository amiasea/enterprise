module "pomology_propagation" {
  source = "./pomology_propagation"

  tf_token = var.tfe_token

  tfe_gha_installation_id = var.tfe_gha_installation_id

  tfe_organization_name = var.tfe_organization_name

  tfe_project = var.tfe_project

  github_organization_name              = var.github_organization_name
  azure_institutive_resource_group_name = var.azure_institutive_resource_group_name

  codeartifact_domain = var.codeartifact_domain

  codeartifact_domain_arn = var.codeartifact_domain_arn

  codeartifact_domain_owner = var.codeartifact_domain_owner

  pomology_propagation_role_arn       = var.pomology_propagation_role_arn
  pomology_artifact_role_boundary_arn = var.pomology_artifact_role_boundary_arn

  github_oidc_provider_arn = var.github_oidc_provider_arn

  azure_tenant_id                   = var.azure_tenant_id
  azure_orchard_client_id           = var.azure_orchard_client_id
  azure_institutive_subscription_id = var.azure_institutive_subscription_id

  gha_id                                 = var.gha_id
  gha_installation_id                    = var.gha_installation_id
  enterprise_orchard_gha_installation_id = var.enterprise_orchard_gha_installation_id
  gha_pem_file                           = var.gha_pem_file
}

module "pomology_pruning" {
  source = "./pomology_pruning"

  tf_token = var.tfe_token

  tfe_gha_installation_id = var.tfe_gha_installation_id

  tfe_organization_name = var.tfe_organization_name

  tfe_project = var.tfe_project

  github_organization_name = var.github_organization_name

  gha_id              = var.gha_id
  gha_installation_id = var.enterprise_orchard_gha_installation_id
  gha_pem_file        = var.gha_pem_file
}
