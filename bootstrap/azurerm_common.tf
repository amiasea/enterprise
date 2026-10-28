data "azurerm_resource_group" "amiasea_imperative" {
  name = "rg-amiasea-imperative"

  provider = azurerm.imperative
}