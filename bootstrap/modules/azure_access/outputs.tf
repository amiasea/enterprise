output "azure_institutive_client_id" {
  value = azurerm_user_assigned_identity.enterprise_workload_institutive.client_id
}

output "azure_orchard_client_id" {
  value = azurerm_user_assigned_identity.enterprise_workload_orchard.client_id
}