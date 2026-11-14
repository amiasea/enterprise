resource "azurerm_user_assigned_identity" "enterprise_workload_institutive" {
  name                = "amiasea-enterprise-workload-institutive"
  resource_group_name = var.azure_institutive_resource_group_name
  location            = var.location
}

resource "azurerm_user_assigned_identity" "enterprise_workload_orchard" {
  name                = "amiasea-enterprise-workload-orchard"
  resource_group_name = var.azure_institutive_resource_group_name
  location            = var.location
}

resource "azurerm_federated_identity_credential" "enterprise_workload_institutive" {
  user_assigned_identity_id = azurerm_user_assigned_identity.enterprise_workload_institutive.id
  for_each = var.institutive_federated_credential_subject_identifiers

  name                = "github-${substr(sha256(each.value), 0, 16)}"

  audience = ["api://AzureADTokenExchange"]
  issuer   = "https://token.actions.githubusercontent.com"
  subject  = each.value
}

resource "azurerm_role_assignment" "enterprise_workload_institutive_key_vault_secrets_user" {
  scope                = var.institutive_key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.enterprise_workload_institutive.principal_id
}

resource "azurerm_role_assignment" "enterprise_workload_orchard_key_vault_secrets_user" {
  scope                = var.institutive_key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.enterprise_workload_orchard.principal_id
}

locals {
  pomology_stack_federated_credentials = {
    pomology_plan = {
      deployment = "pomology"
      operation  = "plan"
    }
    pomology_apply = {
      deployment = "pomology"
      operation  = "apply"
    }
    pomology_testing_plan = {
      deployment = "pomology_testing"
      operation  = "plan"
    }
    pomology_testing_apply = {
      deployment = "pomology_testing"
      operation  = "apply"
    }
  }

  pomology_stack_federated_credential_subjects = {
    for key, credential in local.pomology_stack_federated_credentials :
    key => join(":", [
      "organization", "amiasea",
      "project", var.tfe_institutive_project_name,
      "stack", var.tfe_pomology_propagation_stack_name,
      "deployment", credential.deployment,
      "operation", credential.operation
    ])
  }
}

resource "azurerm_federated_identity_credential" "pomology_stack" {
  for_each = local.pomology_stack_federated_credential_subjects

  user_assigned_identity_id = azurerm_user_assigned_identity.enterprise_workload_orchard.id

  name     = "terraform-${substr(sha256(each.value), 0, 16)}"
  audience = ["api://AzureADTokenExchange"]
  issuer   = "https://app.terraform.io"
  subject  = each.value
}

resource "azurerm_role_definition" "orchard_federated_identity_credential_manager" {
  name        = "Amiasea Orchard Federated Identity Credential Manager"
  scope       = var.azure_institutive_resource_group_id
  description = "Allows the orchard workload identity to manage federated identity credentials on its own managed identity."

  permissions {
    actions = [
      "Microsoft.ManagedIdentity/userAssignedIdentities/read",
      "Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials/read",
      "Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials/write",
      "Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials/delete",
    ]

    not_actions = []
  }

  assignable_scopes = [
    var.azure_institutive_resource_group_id
  ]
}

resource "azurerm_role_assignment" "institutive_federated_identity_credential_manager" {
  scope              = azurerm_user_assigned_identity.enterprise_workload_orchard.id
  role_definition_id = azurerm_role_definition.orchard_federated_identity_credential_manager.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.enterprise_workload_orchard.principal_id
  principal_type     = "ServicePrincipal"
}