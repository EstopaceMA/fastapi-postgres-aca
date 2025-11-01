output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.vnet.name
}

output "containerapp_subnet_id" {
  description = "Container App subnet ID"
  value       = azurerm_subnet.containerapp_subnet.id
}

output "postgres_subnet_id" {
  description = "PostgreSQL subnet ID"
  value       = azurerm_subnet.postgres_subnet.id
}

output "postgres_dns_zone_id" {
  description = "PostgreSQL Private DNS Zone ID"
  value       = azurerm_private_dns_zone.postgres_dns.id
}

output "postgres_dns_zone_name" {
  description = "PostgreSQL Private DNS Zone name"
  value       = azurerm_private_dns_zone.postgres_dns.name
}
