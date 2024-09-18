output "sql_server_id" {
    description = ""
    value = "${azurerm_sql_server.sql-server.id}" 
}

output "sql_server_name" {
    description = ""
    value = "${azurerm_sql_server.sql-server.name}" 
}


output "sql_storage_endpoint" {
    value = "${azurerm_storage_account.storage.primary_blob_endpoint}"
}

output "sql_storage_access_key" {
    value = "${azurerm_storage_account.storage.primary_access_key}" 
}

output "endpoint" {
  value = "${azurerm_private_endpoint.default.private_service_connection}"
}