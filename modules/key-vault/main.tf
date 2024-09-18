

data "azurerm_client_config" "current" {}


/* data "azurerm_private_dns_zone" "this" {
  provider            = azurerm.dns 
  name                = "sample.com"
  resource_group_name = "NetworkWatcherRG"
}
 */

resource "azurerm_key_vault" "azure-key-vault" {
  name                        = "${var.azure_key_vault_name}"
  location                    = "${var.location}"
  resource_group_name         = "${var.resource_group_name}"
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"


  network_acls {
    default_action = "Deny"
    bypass         = "None"
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "get",
    ]
    secret_permissions = [
      "get", "backup", "delete", "list", "purge", "recover", "restore", "set",
    ]
    storage_permissions = [
      "get",
    ]
    certificate_permissions = [
      "get",
    ]
  }

  tags = "${var.tags}"
}



resource "azurerm_private_endpoint" "default" {
  name                = "${var.azure_key_vault_name}-pe"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${var.subnet_id}"

 /*  private_dns_zone_group {
    name                 = "dns-group-${var.azure_key_vault_name}"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.this.id]
  } */

  private_service_connection {
    name                           = "${var.azure_key_vault_name}-pvc"
    private_connection_resource_id = azurerm_key_vault.azure-key-vault.id
    subresource_names              = [ "vault" ]
    is_manual_connection           = false
  }
}

data "azurerm_private_endpoint_connection" "default" {
  name                = "${azurerm_private_endpoint.default.name}"
  resource_group_name = "${var.resource_group_name}"
  depends_on          = [ azurerm_private_endpoint.default ]
}
 

/* resource "azurerm_dns_a_record" "example" {
  provider = azurerm.dns
  name                = "test"
  zone_name           = azurerm_dns_zone.example.name
  resource_group_name = "${var.resource_group_name}"
  ttl                 = 300
   records             = ["${data.azurerm_private_endpoint_connection.default.private_service_connection.0.private_ip_address}"]
} */



 
