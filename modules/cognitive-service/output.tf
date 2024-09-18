output "id" {
  description = "The ids of cognitive service created "
  value       = "${azurerm_cognitive_account.cognitive_service.id}"
}

output "primary_access_key" {
  description = "The primary access key of created cognitive service"
  value       = "${azurerm_cognitive_account.cognitive_service.primary_access_key}"
  sensitive = true
}

output "secondary_access_key" {
  description = "The secondary access key of created cognitive service"
  value       = "${azurerm_cognitive_account.cognitive_service.secondary_access_key}"
  sensitive = true
}

output "endpoint" {
  description = "The endpoint key of created cognitive service"
  value       = "${azurerm_cognitive_account.cognitive_service.endpoint}"
}

output "name" {
  description = "The endpoint key of created cognitive service"
  value       = "${azurerm_cognitive_account.cognitive_service.name}"
}