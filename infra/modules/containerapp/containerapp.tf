# ------------------------------------------------------------------------------------------------------
# DEPLOY LOG ANALYTICS WORKSPACE
# ------------------------------------------------------------------------------------------------------
resource "azurerm_log_analytics_workspace" "logs" {
  name                = "${var.prefix}-logs"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

# ------------------------------------------------------------------------------------------------------
# DEPLOY CONTAINER APP ENVIRONMENT
# ------------------------------------------------------------------------------------------------------
resource "azurerm_container_app_environment" "env" {
  name                       = "${var.prefix}-env"
  location                   = var.location
  resource_group_name        = var.rg_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  tags                       = var.tags
}

# ------------------------------------------------------------------------------------------------------
# DEPLOY CONTAINER REGISTRY
# ------------------------------------------------------------------------------------------------------
resource "azurerm_container_registry" "acr" {
  name                = "${replace(var.prefix, "-", "")}acr"
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = true
  tags                = var.tags
}

# ------------------------------------------------------------------------------------------------------
# DEPLOY CONTAINER APP
# ------------------------------------------------------------------------------------------------------
resource "azurerm_container_app" "app" {
  name                         = "${var.prefix}-app"
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = var.rg_name
  revision_mode                = "Single"
  tags                         = var.tags

  # Registry configuration for ACR authentication
  registry {
    server               = azurerm_container_registry.acr.login_server
    username             = azurerm_container_registry.acr.admin_username
    password_secret_name = "acr-password"
  }

  template {
    container {
      name   = "fastapi-app"
      image  = var.container_image
      cpu    = var.container_cpu
      memory = var.container_memory

      # Environment variables
      dynamic "env" {
        for_each = var.env_vars
        content {
          name        = env.value.name
          secret_name = env.value.secret_name
          value       = env.value.value
        }
      }

      # Liveness probe
      liveness_probe {
        transport = "HTTP"
        port      = var.container_port
        path      = "/"
      }

      # Readiness probe
      readiness_probe {
        transport = "HTTP"
        port      = var.container_port
        path      = "/"
      }
    }

    min_replicas = var.min_replicas
    max_replicas = var.max_replicas
  }

  # Secrets configuration - include ACR password
  secret {
    name  = "acr-password"
    value = azurerm_container_registry.acr.admin_password
  }

  dynamic "secret" {
    for_each = var.secrets
    content {
      name  = secret.value.name
      value = secret.value.value
    }
  }

  ingress {
    external_enabled = true
    target_port      = var.container_port
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}
