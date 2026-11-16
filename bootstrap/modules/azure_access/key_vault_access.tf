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