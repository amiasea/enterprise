resource "tfe_registry_module" "release" {
  organization    = var.tfe_organization_name
  registry_name   = "private"
  name            = "espalier"
  module_provider = "github"

  vcs_repo {
    identifier                 = "amiasea/terraform-github-espalier"
    tags                       = true
    github_app_installation_id = var.tfe_github_app_installation_id
    display_identifier         = "amiasea/terraform-github-espalier"
  }
}
