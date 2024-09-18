output "id" {
  description = "id of created key vault"
  value       = "${azurerm_key_vault.azure-key-vault.id}"
}

output "name" {
  description = "id of created key vault"
  value       = "${azurerm_key_vault.azure-key-vault.name}"
}

output "nic_ip" {
  description = "ip of nic"
  value = data.azurerm_private_endpoint_connection.default.private_service_connection.0.private_ip_address
  
}

output "kv_id" {
  value = azurerm_private_endpoint.default.id
  
}