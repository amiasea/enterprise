#import
data "tfe_project" "imperative" {
  name = "imperative"
  organization = var.tfe_organization_name
}

data "tfe_project" "institutive" {
  name = "institutive"
  organization = var.tfe_organization_name
}

resource "tfe_project" "prospective" {
  name = "prospective"
  organization = var.tfe_organization_name
}

resource "tfe_workspace" "prospective" {
  name         = "prospective"
  project_id   = tfe_project.prospective.id
  organization = var.tfe_organization_name
}

resource "tfe_project" "operative" {
  name = "operative"
  organization = var.tfe_organization_name
}

resource "tfe_workspace" "operative" {
  name         = "operative"
  project_id   = tfe_project.operative.id
  organization = var.tfe_organization_name
}

resource "tfe_registry_module" "espalier" {
  name = "espalier"

  
}

data "tfe_github_app_installation" "gha_installation" {
  name = var.tfe_organization_name
}