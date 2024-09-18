data "azurerm_private_dns_zone" "this" {
  provider            = azurerm.dns 
  name                = "sample.com"
  resource_group_name = "NetworkWatcherRG"
}

resource "azurerm_data_factory" "data_factory" {
  name                            = "${var.data_factory_name}"
  location                        = "${var.location}"
  resource_group_name             = "${var.resource_group_name}"
  managed_virtual_network_enabled = true
  tags                            = "${var.tags}"
}

resource "azurerm_data_factory_integration_runtime_azure" "example" {
  name                = "${azurerm_data_factory.data_factory.name}-integration-runtime"
  data_factory_name   = "${azurerm_data_factory.data_factory.name}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  compute_type        = "${var.runtime_compute_type}"
  core_count          = "${var.runtime_core}"
  time_to_live_min    =  240
}

resource "azurerm_private_endpoint" "default" {
  name                = "pe-${azurerm_data_factory.data_factory.name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${var.subnet_id}"

  private_dns_zone_group {
    name                 = "dns-group-${azurerm_data_factory.data_factory.name}"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.this.id]
  }

  private_service_connection {
    name                           = "${azurerm_data_factory.data_factory.name}-pvc"
    private_connection_resource_id = azurerm_data_factory.data_factory.id
    subresource_names              = [ "portal" ]
    is_manual_connection           = false
  }
}

data "azurerm_private_endpoint_connection" "default" {
  name                = "${azurerm_private_endpoint.default.name}"
  resource_group_name = "${var.resource_group_name}"
  depends_on          = [ azurerm_private_endpoint.default ]
}

