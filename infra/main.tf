locals {
  tags                           = { azd-env-name : var.environment_name }
  postgres_connection_string_key = "POSTGRES-CONNECTION-STRING"
}

# ------------------------------------------------------------------------------------------------------
# Deploy resource Group
# ------------------------------------------------------------------------------------------------------

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
  tags     = local.tags
}

# ------------------------------------------------------------------------------------------------------
# Deploy Virtual Network
# ------------------------------------------------------------------------------------------------------

module "vnet" {
  source   = "./modules/vnet"
  prefix   = var.prefix
  location = var.location
  rg_name  = azurerm_resource_group.rg.name
  tags     = local.tags
}

# ------------------------------------------------------------------------------------------------------
# Deploy PostgresSQL Database
# ------------------------------------------------------------------------------------------------------

module "postgres" {
  source               = "./modules/postgres"
  prefix               = var.prefix
  location             = var.location
  tags                 = local.tags
  rg_name              = azurerm_resource_group.rg.name
  admin_username       = var.admin_username
  postgres_subnet_id   = module.vnet.postgres_subnet_id
  postgres_dns_zone_id = module.vnet.postgres_dns_zone_id

  depends_on = [module.vnet]
}

# ------------------------------------------------------------------------------------------------------
# Deploy key vault
# ------------------------------------------------------------------------------------------------------
module "keyvault" {
  source   = "./modules/keyvault"
  prefix   = var.prefix
  location = var.location
  tags     = local.tags
  rg_name  = azurerm_resource_group.rg.name
  secrets = [
    {
      name  = local.postgres_connection_string_key
      value = module.postgres.connection_string
    }
  ]

  depends_on = [module.postgres]
}

# ------------------------------------------------------------------------------------------------------
# Deploy Container App
# ------------------------------------------------------------------------------------------------------
module "containerapp" {
  source                 = "./modules/containerapp"
  prefix                 = var.prefix
  location               = var.location
  rg_name                = azurerm_resource_group.rg.name
  tags                   = local.tags
  container_image        = var.container_image
  container_port         = var.container_port
  container_cpu          = var.container_cpu
  container_memory       = var.container_memory
  min_replicas           = var.min_replicas
  max_replicas           = var.max_replicas
  containerapp_subnet_id = module.vnet.containerapp_subnet_id

  # Pass the database connection string as a secret
  secrets = [
    {
      name  = "database-url"
      value = module.postgres.connection_string
    }
  ]

  # Environment variables
  env_vars = [
    {
      name        = "DATABASE_URL"
      secret_name = "database-url"
      value       = null
    }
  ]

  depends_on = [module.postgres, module.keyvault, module.vnet]
}
