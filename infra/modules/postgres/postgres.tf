# ------------------------------------------------------------------------------------------------------
# DEPLOY POSTGRESQL FLEXIBLE SERVER WITH PRIVATE NETWORKING
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

  # Private networking configuration
  delegated_subnet_id = var.postgres_subnet_id
  private_dns_zone_id = var.postgres_dns_zone_id

  # Disable public network access for security
  public_network_access_enabled = false

  tags = var.tags
}

