resource "azurerm_eventhub_namespace" "default" {
  name                = "${var.eventhub_namespace_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "${var.Eventhub_sku}"
  capacity            = "${var.eventhub_capacity}"
  tags                = "${var.tags}"
}

module "events" {
  source = "./events"
  eventhub_namespace_name = "${var.eventhub_namespace_name}"
  resource_group_name = "${var.resource_group_name}"
  key_vault_id = "${var.key_vault_id}"
  count = length(var.event_name)
  event_name = "${var.event_name[count.index]}"
}
/*
resource "azurerm_private_endpoint" "default" {
  name                = "${var.eventhub_namespace_name}-pe"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${var.subnet_id}"

  private_service_connection {
    name                           = "${var.eventhub_namespace_name}-pvc"
    private_connection_resource_id = azurerm_eventhub_namespace.default.id
    subresource_names              = [ "namespace" ]
    is_manual_connection           = false
  }
}

*/
/*
resource "azurerm_eventhub" "eventhub" {
  count               = length(var.event_name)
  name                = "${var.event_name[count.index]}"
  namespace_name      = "${azurerm_eventhub_namespace.default.name}"
  resource_group_name = "${var.resource_group_name}"
  partition_count     = 2
  message_retention   = 1
}
*/




