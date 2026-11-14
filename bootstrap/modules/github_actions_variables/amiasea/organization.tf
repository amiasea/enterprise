////// amiasea //////

resource "github_actions_organization_variable" "aws_account_id" {
  variable_name = "AWS_ACCOUNT_ID"
  value         = var.aws_account_id
  visibility    = "selected"
  selected_repository_ids = var.repository_ids
}

resource "github_actions_organization_variable" "codeartifact_domain" {
  variable_name = "AWS_CODEARTIFACT_DOMAIN"
  value         = var.codeartifact_domain
  visibility    = "selected"
  selected_repository_ids = var.repository_ids
}

resource "github_actions_organization_variable" "institutive_key_vault_name" {
  variable_name           = "INSTITUTIVE_KEY_VAULT_NAME"
  value                   = var.institutive_key_vault_name
  visibility              = "selected"
  selected_repository_ids = var.repository_ids
}

resource "github_actions_organization_variable" "institutive_key_vault_uri" {
  variable_name           = "INSTITUTIVE_KEY_VAULT_URI"
  value                   = var.institutive_key_vault_uri
  visibility              = "selected"
  selected_repository_ids = var.repository_ids
}

resource "github_actions_organization_variable" "ps_gallery_api_key_versionless_id" {
  variable_name           = "PS_GALLERY_API_KEY_VERSIONLESS_ID"
  value                   = var.ps_gallery_api_key_versionless_id
  visibility              = "selected"
  selected_repository_ids = var.repository_ids
}

resource "github_actions_organization_variable" "amiasea_webhook_token_versionless_id" {
  variable_name           = "AMIASEA_WEBHOOK_TOKEN_VERSIONLESS_ID"
  value                   = var.amiasea_webhook_token_versionless_id
  visibility              = "selected"
  selected_repository_ids = var.repository_ids
}

resource "github_actions_organization_variable" "amiasea_github_app_pem_file_versionless_id" {
  variable_name           = "AMIASEA_GITHUB_APP_PEM_FILE_VERSIONLESS_ID"
  value                   = var.amiasea_github_app_pem_file_versionless_id
  visibility              = "selected"
  selected_repository_ids = var.repository_ids
}

resource "github_actions_organization_variable" "amiasea_tfe_token_versionless_id" {
  variable_name           = "AMIASEA_TFE_TOKEN_VERSIONLESS_ID"
  value                   = var.amiasea_tfe_token_versionless_id
  visibility              = "selected"
  selected_repository_ids = var.repository_ids
}

resource "github_actions_organization_variable" "azure_tenant_id" {
  variable_name           = "AZURE_INSTITUTIVE_TENANT_ID"
  value                   = var.azure_tenant_id
  visibility              = "selected"
  selected_repository_ids = var.repository_ids
}

resource "github_actions_organization_variable" "azure_institutive_subscription_id" {
  variable_name           = "AZURE_INSTITUTIVE_SUBSCRIPTION_ID"
  value                   = var.azure_institutive_subscription_id
  visibility              = "selected"
  selected_repository_ids = var.repository_ids
}

resource "github_actions_organization_variable" "azure_institutive_client_id" {
  variable_name           = "AZURE_INSTITUTIVE_CLIENT_ID"
  value                   = var.azure_institutive_client_id
  visibility              = "selected"
  selected_repository_ids = var.repository_ids
}

resource "github_actions_organization_variable" "github_app_id" {
  variable_name           = "AMIASEA_GITHUB_APP_ID"
  value                   = var.gha_id
  visibility              = "selected"
  selected_repository_ids = var.repository_ids
}