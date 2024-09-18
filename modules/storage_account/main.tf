resource "azurerm_storage_account" "azure_storage_account" {
  name                     = "${var.storage_account_name}"
  resource_group_name      = "${var.resource_group_name}"
  location                 = "${var.location}"
  account_tier             = "${var.account_tier}"
  access_tier              = "${var.access_tier}"
  account_replication_type = "${var.replication_type}"
  network_rules {
    default_action = Deny
  }
  tags                     = "${var.tags}"
}

resource "azurerm_storage_container" "azure_storage_container" { 
  count                 = "${var.container_required == true ? length(var.storage_container_name) : 0}"
  name                  = "${var.storage_container_name[count.index]}"
  storage_account_name  = "${azurerm_storage_account.azure_storage_account.name}"
  container_access_type = "${var.container_access_type}"
}


resource "azurerm_key_vault_secret" "azure_key_vault_secret" {
  name         = "${azurerm_storage_account.azure_storage_account.name}"
  value        = "${azurerm_storage_account.azure_storage_account.primary_access_key}"
  key_vault_id = "${var.key_vault_id}"
}


resource "azurerm_private_endpoint" "default" {
  name                = "${var.storage_account_name}-pe"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${var.subnet_id}"

  private_service_connection {
    name                           = "${var.storage_account_name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = "${azurerm_storage_account.azure_storage_account.id}"
    subresource_names              = ["blob"]
  }

}

data "azurerm_private_endpoint_connection" "default" {
  name                = "${var.storage_account_name}-pe"
  resource_group_name = "${var.resource_group_name}"
  depends_on          = [ azurerm_private_endpoint.default ]
}