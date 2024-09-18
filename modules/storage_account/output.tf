output "storage_account_id" {
  description = "The ids of storage account created "
  value       = "${azurerm_storage_account.azure_storage_account.id}"
}

output "name" {
  description = "The name of storage account created"
  value = "${azurerm_storage_account.azure_storage_account.name}"
}

output "primary_access_key" {
  description = "The name of storage account created"
  value = "${azurerm_storage_account.azure_storage_account.primary_access_key}"
}

output "nic_ip" {
  description = "ip of nic"
  value = data.azurerm_private_endpoint_connection.default.private_service_connection.0.private_ip_address
  
}