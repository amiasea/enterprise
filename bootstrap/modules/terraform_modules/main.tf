module "espalier" {
  source = "./espalier"

  tfe_organization_name = var.tfe_organization_name

  tfe_gha_installation_id = var.tfe_gha_installation_id

  gha_id              = var.gha_id
  gha_installation_id = var.gha_installation_id
  gha_pem_file        = var.gha_pem_file
}
