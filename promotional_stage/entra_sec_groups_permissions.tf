resource "azurerm_role_assignment" "enterprise_sql_admins_server_contributor" {
  scope                = azurerm_mssql_server.enterprise.id
  role_definition_name = "SQL Server Contributor"
  principal_id         = azuread_group.enterprise_sql_admins.object_id
  principal_type       = "Group"
}

resource "azurerm_role_assignment" "enterprise_sql_admins_security_manager" {
  scope                = azurerm_mssql_server.enterprise.id
  role_definition_name = "SQL Security Manager"
  principal_id         = azuread_group.enterprise_sql_admins.object_id
  principal_type       = "Group"
}