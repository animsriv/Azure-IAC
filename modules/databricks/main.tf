

data "azurerm_client_config" "current" {}



resource "azurerm_subnet" "public" {
  name                 = "${var.databrick_name}-sn-public"
  resource_group_name  = "${var.vnet_resource_group_name}"
  virtual_network_name = "${var.vnet_name}"
  address_prefixes     = ["${var.public_sn_address_prefix}"]

  delegation {
    name = "databricks-del-pub-${var.databrick_name}"

    service_delegation {
      actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet" "private" {
  name                 = "${var.databrick_name}-sn-private"
  resource_group_name  = "${var.vnet_resource_group_name}"
  virtual_network_name = "${var.vnet_name}"
  address_prefixes     = ["${var.private_sn_address_prefix}"]

  delegation {
    name = "databricks-del-pri-${var.databrick_name}"

    service_delegation {
      actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = "${azurerm_subnet.private.id}"
  network_security_group_id = "${azurerm_network_security_group.security_group.id}"
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = "${azurerm_subnet.public.id}"
  network_security_group_id = "${azurerm_network_security_group.security_group.id}"
}

resource "azurerm_network_security_group" "security_group" {
  name                = "${var.databrick_name}-nsg-databricks"
  location            = "${var.location}"
  resource_group_name = "${var.vnet_resource_group_name}"
}

resource "azurerm_databricks_workspace" "databrick" {
  name                        = "${var.databrick_name}"
  resource_group_name         = "${var.resource_group_name}"
  location                    = "${var.location}"
  sku                         = "${var.databrick_sku}"
  managed_resource_group_name = "${var.databrick_name}-DBW-managed-resource-group"
  public_network_access_enabled             = false
  network_security_group_rules_required     = "NoAzureDatabricksRules"

  custom_parameters {
    no_public_ip        = true
    public_subnet_name  = "${azurerm_subnet.public.name}"
    private_subnet_name = "${azurerm_subnet.private.name}"
    virtual_network_id  = "${var.virtual_network_id}"

    public_subnet_network_security_group_association_id  = "${azurerm_subnet_network_security_group_association.public.id}"
    private_subnet_network_security_group_association_id = "${azurerm_subnet_network_security_group_association.private.id}"
  }
  tags = "${var.tags}"
}


