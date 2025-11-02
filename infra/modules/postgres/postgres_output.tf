
output "fqdn" {
  value = azurerm_postgresql_flexible_server.pg.fqdn
}

output "username" {
  value = "${var.admin_username}@${azurerm_postgresql_flexible_server.pg.name}"
}

output "connection_string" {
  description = "PostgreSQL connection string"
  value       = "postgresql://${var.admin_username}:${random_password.postgres_admin.result}@${azurerm_postgresql_flexible_server.pg.fqdn}:5432/postgres?sslmode=require"
  sensitive   = true
}

output "admin_password" {
  description = "Auto-generated PostgreSQL admin password"
  value       = random_password.postgres_admin.result
  sensitive   = true
}
