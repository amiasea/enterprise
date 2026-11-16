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