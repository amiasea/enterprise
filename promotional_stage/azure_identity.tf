data "azuread_client_config" "current" {}

resource "azuread_directory_role" "directory_readers" {
  display_name = "Directory Readers"
}

resource "azuread_directory_role_assignment" "sql_server_directory_readers" {
  role_id             = azuread_directory_role.directory_readers.template_id
  principal_object_id = azurerm_mssql_server.enterprise.identity[0].principal_id
}

resource "azurerm_user_assigned_identity" "enterprise_workload" {
  name                = "amiasea-enterprise-workload-${lower(var.stage)}"
  resource_group_name = azurerm_resource_group.enterprise.name
  location            = azurerm_resource_group.enterprise.location
}

resource "azurerm_user_assigned_identity" "enterprise_api" {
  name                = "amiasea-enterprise-api-${lower(var.stage)}"
  resource_group_name = azurerm_resource_group.enterprise.name
  location            = azurerm_resource_group.enterprise.location
}

# data "azurerm_billing_mca_account_scope" "imperative" {
#   billing_account_name  = "e6f21f58-2e79-4634-a6bc-73667055877b:bbbb9159-b15e-4009-8cd8-73c88b42f6aa_2019-05-31"
#   billing_profile_name  = "MUGO-ML6Y-BG7-PGB"
#   invoice_section_name  = "V4EB-6NK3-PJA-PGB"
# }

# resource "azurerm_subscription" "imperative" {
#   subscription_name = "amiasea-imperative-${lower(var.stage)}"
#   billing_scope_id  = data.azurerm_billing_mca_account_scope.imperative.id
# }

data "azurerm_key_vault" "institutive" {
  name                = "kv-amiasea-institutive"
  resource_group_name = "amiasea-enterprise-institutive"

  provider = azurerm.institutive
}

resource "azurerm_role_assignment" "enterprise_institutive_key_vault_certificate_user" {
  scope                = data.azurerm_key_vault.institutive.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.enterprise_workload.principal_id
  principal_type       = "ServicePrincipal"
}

resource "azuread_directory_role" "application_administrator" {
  display_name = "Application Administrator"
}

resource "azuread_directory_role_assignment" "enterprise_application_administrator" {
  role_id             = azuread_directory_role.application_administrator.template_id
  principal_object_id = azurerm_user_assigned_identity.enterprise_workload.principal_id
}

resource "azuread_directory_role_assignment" "enterprise_directory_readers" {
  role_id             = azuread_directory_role.directory_readers.template_id
  principal_object_id = azurerm_user_assigned_identity.enterprise_workload.principal_id
}

resource "azuread_directory_role" "tenant_creator" {
  display_name = "Tenant Creator"
}

resource "azuread_directory_role_assignment" "enterprise_tenant_creator" {
  role_id             = azuread_directory_role.tenant_creator.template_id
  principal_object_id = azurerm_user_assigned_identity.enterprise_workload.principal_id
}



# CIAM

# Microsoft.ManagedIdentity userAssignedIdentities/federatedIdentityCredentials