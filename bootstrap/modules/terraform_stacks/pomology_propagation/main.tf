resource "tfe_stack" "enterprise_pomology_propagation" {
  name                = "enterprise-pomology-propagation"
  description         = "Propagates Amiasea enterprise pomology flora."
  project_id          = var.tfe_project.id

  lifecycle {
    ignore_changes = [vcs_repo]
  }
}

resource "terraform_data" "enterprise_pomology_propagation_vcs" {
  triggers_replace = {
    stack_id                   = tfe_stack.enterprise_pomology_propagation.id
    github_app_installation_id = var.tfe_gha_installation_id
  }

  provisioner "local-exec" {
    interpreter = ["pwsh", "-NoProfile", "-NonInteractive", "-Command"]

    environment = {
      HCP_TOKEN                  = var.tf_token
      HCP_STACK_ID               = self.triggers_replace.stack_id
      GITHUB_APP_INSTALLATION_ID = self.triggers_replace.github_app_installation_id
    }

    command = <<-EOT
      $ErrorActionPreference = "Stop"

      $headers = @{
        Authorization = "Bearer $env:HCP_TOKEN"
        Accept        = "application/vnd.api+json"
      }

      $body = @{
        data = @{
          type = "stacks"
          attributes = @{
            "vcs-repo" = @{
              identifier                  = "amiasea/enterprise-pomology-propagation"
              "github-app-installation-id" = $env:GITHUB_APP_INSTALLATION_ID
              "service-provider"          = "github"
              "trigger-disabled"          = $true
            }
          }
        }
      } | ConvertTo-Json -Depth 10

      Invoke-RestMethod `
        -Method Patch `
        -Uri "https://app.terraform.io/api/v2/stacks/$env:HCP_STACK_ID" `
        -Headers $headers `
        -ContentType "application/vnd.api+json" `
        -Body $body
    EOT
  }
}

resource "tfe_variable_set" "pomology_propagation_varset" {
  name         = "enterprise-pomology-propagation"
  description  = "Enterprise Pomology Propagation Varset."
  organization = var.tfe_organization_name
}

resource "tfe_stack_variable_set" "pomology_propagation_stack_varset" {
  stack_id        = tfe_stack.enterprise_pomology_propagation.id
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "gha_id" {
  key             = "gha_id"
  category        = "terraform"
  value_wo        = var.gha_id
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "gha_installation_id" {
  key             = "gha_installation_id"
  category        = "terraform"
  value_wo        = var.gha_installation_id
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "enterprise_orchard_gha_installation_id" {
  key             = "enterprise_orchard_gha_installation_id"
  category        = "terraform"
  value_wo        = var.enterprise_orchard_gha_installation_id
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "gha_pem_file" {
  key             = "gha_pem_file"
  category        = "terraform"
  value_wo        = var.gha_pem_file
  sensitive       = true
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "github_organization_name" {
  key             = "github_organization_name"
  category        = "terraform"
  value           = var.github_organization_name
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "codeartifact_domain" {
  key             = "codeartifact_domain"
  category        = "terraform"
  value           = var.codeartifact_domain
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "codeartifact_domain_arn" {
  key             = "codeartifact_domain_arn"
  category        = "terraform"
  value           = var.codeartifact_domain_arn
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "codeartifact_domain_owner" {
  key             = "codeartifact_domain_owner"
  category        = "terraform"
  value           = var.codeartifact_domain_owner
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "pomology_propagation_role_arn" {
  key             = "pomology_propagation_role_arn"
  category        = "terraform"
  value           = var.pomology_propagation_role_arn
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "pomology_artifact_role_boundary_arn" {
  key             = "pomology_artifact_role_boundary_arn"
  category        = "terraform"
  value           = var.pomology_artifact_role_boundary_arn
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "github_oidc_provider_arn" {
  key             = "github_oidc_provider_arn"
  category        = "terraform"
  value           = var.github_oidc_provider_arn
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "azure_institutive_resource_group_name" {
  key             = "azure_institutive_resource_group_name"
  category        = "terraform"
  value           = var.azure_institutive_resource_group_name
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "azure_tenant_id" {
  key             = "azure_tenant_id"
  category        = "terraform"
  value           = var.azure_tenant_id
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "azure_orchard_client_id" {
  key             = "azure_orchard_client_id"
  category        = "terraform"
  value           = var.azure_orchard_client_id
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}

resource "tfe_variable" "azure_institutive_subscription_id" {
  key             = "azure_institutive_subscription_id"
  category        = "terraform"
  value           = var.azure_institutive_subscription_id
  variable_set_id = tfe_variable_set.pomology_propagation_varset.id
}