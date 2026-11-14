resource "tfe_stack" "enterprise_pomology_pruning" {
  name                = "enterprise-pomology-pruning"
  description         = "Prunes Amiasea enterprise pomology flora."
  project_id          = var.tfe_project.id

  lifecycle {
    ignore_changes = [vcs_repo]
  }
}

resource "terraform_data" "enterprise_pomology_pruning_vcs" {
  triggers_replace = {
    stack_id                   = tfe_stack.enterprise_pomology_pruning.id
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
              identifier                  = "amiasea/enterprise-pomology-pruning"
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

resource "tfe_variable_set" "pomology_pruning_varset" {
  name         = "enterprise-pomology-pruning"
  description  = "Enterprise Pomology Pruning Varset."
  organization = var.tfe_organization_name
}

resource "tfe_stack_variable_set" "pomology_pruning_stack_varset" {
  stack_id        = tfe_stack.enterprise_pomology_pruning.id
  variable_set_id = tfe_variable_set.pomology_pruning_varset.id
}

resource "tfe_variable" "gha_id" {
  key             = "gha_id"
  category        = "terraform"
  value_wo        = var.gha_id
  variable_set_id = tfe_variable_set.pomology_pruning_varset.id
}

resource "tfe_variable" "gha_installation_id" {
  key             = "gha_installation_id"
  category        = "terraform"
  value_wo        = var.gha_installation_id
  variable_set_id = tfe_variable_set.pomology_pruning_varset.id
}

resource "tfe_variable" "gha_pem_file" {
  key             = "gha_pem_file"
  category        = "terraform"
  value_wo        = var.gha_pem_file
  sensitive       = true
  variable_set_id = tfe_variable_set.pomology_pruning_varset.id
}

resource "tfe_variable" "github_organization_name" {
  key             = "github_organization_name"
  category        = "terraform"
  value           = var.github_organization_name
  variable_set_id = tfe_variable_set.pomology_pruning_varset.id
}
