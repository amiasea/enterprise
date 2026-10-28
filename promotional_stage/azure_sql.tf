resource "azurerm_mssql_server" "enterprise" {
  name                          = "amiasea-enterprise-${lower(var.stage)}"
  resource_group_name           = azurerm_resource_group.enterprise.name
  location                      = azurerm_resource_group.enterprise.location
  version                       = "12.0"
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true

  identity {
    type = "SystemAssigned"
  }

  azuread_administrator {
    login_username              = azuread_group.enterprise_sql_admins.display_name
    object_id                   = azuread_group.enterprise_sql_admins.object_id
    tenant_id                   = data.azuread_client_config.current.tenant_id
    azuread_authentication_only = true
  }
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.enterprise.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0" # "0.0.0.0" tells Azure SQL to allow all native internal Azure resources
}