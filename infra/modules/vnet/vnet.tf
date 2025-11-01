# ------------------------------------------------------------------------------------------------------
# DEPLOY VIRTUAL NETWORK
# ------------------------------------------------------------------------------------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]
  tags                = var.tags
}

# ------------------------------------------------------------------------------------------------------
# SUBNET FOR CONTAINER APPS ENVIRONMENT
# ------------------------------------------------------------------------------------------------------
resource "azurerm_subnet" "containerapp_subnet" {
  name                 = "${var.prefix}-containerapp-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/23"]

  # NOTE: Container Apps Environment does NOT require delegation
  # The environment itself manages the subnet - no delegation needed
}

# ------------------------------------------------------------------------------------------------------
# SUBNET FOR POSTGRESQL FLEXIBLE SERVER
# ------------------------------------------------------------------------------------------------------
resource "azurerm_subnet" "postgres_subnet" {
  name                 = "${var.prefix}-postgres-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  # Delegation required for PostgreSQL Flexible Server
  delegation {
    name = "Microsoft.DBforPostgreSQL.flexibleServers"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }

  # Service endpoints for PostgreSQL
  service_endpoints = ["Microsoft.Storage"]
}

# ------------------------------------------------------------------------------------------------------
# PRIVATE DNS ZONE FOR POSTGRESQL
# ------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_zone" "postgres_dns" {
  name                = "${var.prefix}.postgres.database.azure.com"
  resource_group_name = var.rg_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_dns_link" {
  name                  = "${var.prefix}-postgres-dns-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.postgres_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  tags                  = var.tags
}
