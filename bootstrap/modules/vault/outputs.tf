output "institutive_key_vault_name" {
  value = azurerm_key_vault.institutive.name
}

output "institutive_key_vault_id" {
  value = azurerm_key_vault.institutive.id
}

output "institutive_key_vault_uri" {
  value = azurerm_key_vault.institutive.vault_uri
}

output "ps_gallery_api_key_versionless_id" {
  value = azurerm_key_vault_secret.ps_gallery_api_key.versionless_id
}

output "amiasea_webhook_token_versionless_id" {
  value = azurerm_key_vault_secret.amiasea_webhook_token.versionless_id
}

output "amiasea_github_app_pem_file_versionless_id" {
  value = azurerm_key_vault_secret.amiasea_github_app_pem_file.versionless_id
}

output "amiasea_tfe_token_versionless_id" {
  value = azurerm_key_vault_secret.amiasea_tfe_token.versionless_id
}