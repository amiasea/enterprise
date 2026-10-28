resource "azuread_group" "enterprise_sql_admins" {
  display_name     = "Amiasea Enterprise SQL Admin - ${var.stage}"
  security_enabled = true
}

resource "azuread_group" "enterprise_sql_migrations" {
  display_name     = "Amiasea Enterprise SQL Migration - ${var.stage}"
  security_enabled = true
}

resource "azuread_group" "enterprise_sql_data_access" {
  display_name     = "Amiasea Enterprise SQL Data Access - ${var.stage}"
  security_enabled = true
}