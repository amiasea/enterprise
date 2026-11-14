resource "azurerm_key_vault" "institutive" {
  name = "kv-amiasea-institutive"
  tenant_id = var.tenant_id
  resource_group_name = "amiasea-enterprise-institutive"

  sku_name = "standard"
  location = var.location

  rbac_authorization_enabled = true
}

resource "azurerm_key_vault_secret" "ps_gallery_api_key" {
  name             = "ps-gallery-api-key"
  value_wo         = var.ps_gallery_api_key
  value_wo_version = 1
  key_vault_id     = azurerm_key_vault.institutive.id
}

resource "azurerm_key_vault_secret" "amiasea_webhook_token" {
  name             = "amiasea-webhook-token"
  value_wo         = var.amiasea_webhook_token
  value_wo_version = 1
  key_vault_id     = azurerm_key_vault.institutive.id
}

resource "azurerm_key_vault_secret" "amiasea_github_app_pem_file" {
  name             = "amiasea-github-app-pem-file"
  value_wo         = var.amiasea_github_app_pem_file
  value_wo_version = 1
  key_vault_id     = azurerm_key_vault.institutive.id
}

resource "azurerm_key_vault_secret" "amiasea_tfe_token" {
  name             = "amiasea-tfe-token"
  value_wo         = var.amiasea_tfe_token
  value_wo_version = 1
  key_vault_id     = azurerm_key_vault.institutive.id
}