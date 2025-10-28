
output "fqdn" {
  value = azurerm_postgresql_flexible_server.pg.fqdn
}

output "username" {
  value = "${var.admin_username}@${azurerm_postgresql_flexible_server.pg.name}"
}

output "connection_string" {
  description = "PostgreSQL connection string"
  value       = "postgresql://${var.admin_username}:${var.admin_password}@${azurerm_postgresql_flexible_server.pg.fqdn}:5432/postgres?sslmode=require"
  sensitive   = true
}
