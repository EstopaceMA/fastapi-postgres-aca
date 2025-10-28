output "POSTGRES_CONNECTION_STRING_KEY" {
  value = local.postgres_connection_string_key
}

output "AZURE_KEY_VAULT_ENDPOINT" {
  value     = module.keyvault.AZURE_KEY_VAULT_ENDPOINT
  sensitive = true
}

output "AZURE_LOCATION" {
  value = var.location
}

# ------------------------------------------------------------------------------------------------------
# Azure Container Registry Outputs
# ------------------------------------------------------------------------------------------------------

output "ACR_NAME" {
  description = "The name of the Azure Container Registry"
  value       = module.containerapp.acr_name
}

output "ACR_LOGIN_SERVER" {
  description = "The Azure Container Registry login server"
  value       = module.containerapp.acr_login_server
}

output "AZURE_CONTAINER_REGISTRY_ENDPOINT" {
  description = "The Azure Container Registry endpoint for azd"
  value       = module.containerapp.acr_login_server
}

output "ACR_ADMIN_USERNAME" {
  description = "The admin username for the Azure Container Registry"
  value       = module.containerapp.acr_admin_username
}

# ------------------------------------------------------------------------------------------------------
# Container App Outputs
# ------------------------------------------------------------------------------------------------------

output "CONTAINER_APP_NAME" {
  description = "The name of the deployed Container App"
  value       = module.containerapp.container_app_name
}

output "CONTAINER_APP_URL" {
  description = "The public URL of the Container App"
  value       = module.containerapp.container_app_url
}

output "CONTAINER_APP_FQDN" {
  description = "The FQDN of the Container App"
  value       = module.containerapp.container_app_fqdn
}
