# ------------------------------------------------------------------------------------------------------
# DEPLOY POSTGRESQL SERVER
# ------------------------------------------------------------------------------------------------------
resource "azurerm_postgresql_flexible_server" "pg" {
  name                   = "${var.prefix}-pgflex"
  resource_group_name    = var.rg_name
  location               = var.location
  version                = var.postgres_version
  administrator_login    = var.admin_username
  administrator_password = var.admin_password
  sku_name               = var.sku_name
  storage_mb             = 32768
}

