resource "azurerm_cognitive_account" "cognitive_service" {
  name                = "${var.cognitive_service_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  kind                = "${var.cognitive_service_kind}"
  custom_subdomain_name = "${var.cognitive_service_name}"

  sku_name = "${var.sku_name}"

  tags = "${var.tags}"
}



resource "azurerm_key_vault_secret" "azure_key_vault_secret" {
  name         = "${azurerm_cognitive_account.cognitive_service.name}"
  value        = "${azurerm_cognitive_account.cognitive_service.primary_access_key}"
  key_vault_id = "${var.key_vault_id}"
}


resource "azurerm_private_endpoint" "default" {
  name                = "${var.cognitive_service_name}-pe"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${var.subnet_id}"

  private_service_connection {
    name                           = "${var.cognitive_service_name}-pvc"
    private_connection_resource_id = azurerm_cognitive_account.cognitive_service.id
    subresource_names              = [ "account" ]
    is_manual_connection           = false
  }
}