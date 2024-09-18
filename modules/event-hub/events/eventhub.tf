resource "azurerm_eventhub" "eventhub" {
  name                = "${var.event_name}"
  namespace_name       = "${var.eventhub_namespace_name}"
  resource_group_name = "${var.resource_group_name}"
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "eventhub_auth" {
  name                = "${var.event_name}-sas"
  namespace_name      = "${var.eventhub_namespace_name}"
  eventhub_name       = "${azurerm_eventhub.eventhub.name}"
  resource_group_name = "${var.resource_group_name}"
  listen              = true
  send                = true
  manage              = true

  depends_on = [
    azurerm_eventhub.eventhub,
  ]
}

resource "azurerm_key_vault_secret" "secet" {
    name         = "${var.event_name}"
    value        = "${azurerm_eventhub_authorization_rule.eventhub_auth.primary_key}"
    key_vault_id = "${var.key_vault_id}"
}

