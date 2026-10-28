resource "azuread_group_member" "enterprise_workload_sql_admins" {
  group_object_id  = azuread_group.enterprise_sql_admins.object_id
  member_object_id = azurerm_user_assigned_identity.enterprise_workload.principal_id
}

resource "azuread_group_member" "enterprise_workload_sql_migrations" {
  group_object_id  = azuread_group.enterprise_sql_migrations.object_id
  member_object_id = azurerm_user_assigned_identity.enterprise_workload.principal_id
}

resource "azuread_group_member" "enterprise_workload_sql_data_access" {
  group_object_id  = azuread_group.enterprise_sql_data_access.object_id
  member_object_id = azurerm_user_assigned_identity.enterprise_api.principal_id
}