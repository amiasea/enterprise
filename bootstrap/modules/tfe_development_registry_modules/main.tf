resource "tfe_registry_module" "espalier" {
  organization    = var.tfe_organization_name
  registry_name   = "private"
  name            = "espalier"
  module_provider = "github"

  vcs_repo {
    identifier                 = "amiasea/terraform-github-espalier"
    branch                     = "development"
    github_app_installation_id = var.tfe_github_app_installation_id
    display_identifier         = "amiasea/terraform-github-espalier"
  }

  test_config {
    tests_enabled = true
  }
}

resource "tfe_test_variable" "github_app_id" {
  organization   = var.tfe_organization_name
  module_name    = tfe_registry_module.espalier.name
  module_provider = tfe_registry_module.espalier.module_provider

  key      = "GITHUB_APP_ID"
  value    = var.github_app_id
  category = "env"
}

resource "tfe_test_variable" "github_app_installation_id" {
  organization    = var.tfe_organization_name
  module_name     = tfe_registry_module.espalier.name
  module_provider = tfe_registry_module.espalier.module_provider

  key      = "GITHUB_APP_INSTALLATION_ID"
  value    = var.github_app_installation_id
  category = "env"
}

resource "tfe_test_variable" "github_app_pem_file" {
  organization    = var.tfe_organization_name
  module_name     = tfe_registry_module.espalier.name
  module_provider = tfe_registry_module.espalier.module_provider

  key       = "GITHUB_APP_PEM_FILE"
  value     = var.github_app_pem_file
  category  = "env"
  sensitive = true
}