output "container_app_name" {
  description = "The name of the container app"
  value       = azurerm_container_app.app.name
}

output "container_app_fqdn" {
  description = "The FQDN of the container app"
  value       = azurerm_container_app.app.ingress[0].fqdn
}

output "container_app_url" {
  description = "The full URL of the container app"
  value       = "https://${azurerm_container_app.app.ingress[0].fqdn}"
}

output "container_app_environment_id" {
  description = "The ID of the container app environment"
  value       = azurerm_container_app_environment.env.id
}

output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.logs.id
}

output "acr_name" {
  description = "The name of the Azure Container Registry"
  value       = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "The login server URL for the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "The admin username for the Azure Container Registry"
  value       = azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
  description = "The admin password for the Azure Container Registry"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}
