locals {
  orchard_federated_credential_subject_identifiers = setunion(
    var.topology_federated_credential_subject_identifiers,
    var.fruit_federated_credential_subject_identifiers
  )
}

resource "azurerm_federated_identity_credential" "enterprise_workload_institutive" {
  for_each = var.institutive_federated_credential_subject_identifiers

  name = "github-${substr(sha256(each.value), 0, 16)}"

  user_assigned_identity_id = azurerm_user_assigned_identity.enterprise_workload_institutive.id

  audience = ["api://AzureADTokenExchange"]
  issuer   = "https://token.actions.githubusercontent.com"
  subject  = each.value
}

resource "azurerm_federated_identity_credential" "enterprise_workload_orchard" {
  for_each = local.orchard_federated_credential_subject_identifiers

  name = "github-${substr(sha256(each.value), 0, 16)}"

  user_assigned_identity_id = azurerm_user_assigned_identity.enterprise_workload_orchard.id

  audience = ["api://AzureADTokenExchange"]
  issuer   = "https://token.actions.githubusercontent.com"
  subject  = each.value
}