resource "azurerm_resource_group" "enterprise" {
  name     = "amiasea-enterprise-${lower(var.stage)}"
  location = var.location
}