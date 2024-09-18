

data "azurerm_client_config" "current" {
}




data "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_name}"
  resource_group_name = "${var.vnet_resource_group_name}"
}

data "azurerm_subnet" "pe-subnet" {
  virtual_network_name = "${var.vnet_name}"
  name                = "${var.private_endpoint_subnet}"
  resource_group_name = "${var.vnet_resource_group_name}"
}

module "resource_group" {
    source              = "../../modules/resource_group"  
    resource_group_name = "${local.resource_group_name}"
    location            = "${var.location}" 
    tags                = "${merge(var.default_tags,tomap({type="resource_group"}))}"
}

/* module "subnets" {
  source              = "../../modules/subnet"
  resource_group_name = "${var.vnet_resource_group_name}"
  location            = "${var.location}"
  tags                = "${merge(var.default_tags,tomap({"type"="subnet"}))}"
  vnet_name           = "${var.vnet_name}"
  add_endpoint        =  false
  subnets = [
    {
      name   = "${var.subnet_name}"
      prefix = "${var.subnet_prefix}"
    }
  ]
  depends_on = [
    module.resource_group,
  ]
} */
module "subnet" {
  source              = "../../modules/subnet"
  resource_group_name = "${var.vnet_resource_group_name}"
  location            = "${var.location}"
  tags                = "${merge(var.default_tags,tomap({"type"="cda subnet"}))}"
  vnet_name           = "${var.vnet_name}"
  add_endpoint        =  false
  subnets = [
    {
      name   = "${local.subnet_name}"
      prefix = "${var.vm_subnet_prefix}"
    }
  ]
}

module "nsg" {
  source              = "../../modules/network-security-group"
  nsg_name            = "${local.nsg_name}"
  resource_group_name = "${module.resource_group.resource_group_name}"
  location            = "${var.location}"
  tags                = "${merge(var.default_tags,tomap({type="cda-nsg"}))}"

  depends_on = [
   module.resource_group
  ]
}


module "disk" {
  source              = "../../modules/disk"
  disk_name           = "${local.vm_name}"
  location            = "${var.location}"
  resource_group_name = "${module.resource_group.resource_group_name}"
  disk_size           = "${var.disk_size}"
  tags                = "${merge(var.default_tags,tomap({type="application-disk"}))}"

  depends_on = [
    module.resource_group,
  ]
}


module "vm" {
  source              = "../../modules/virtual-machine"
  server_name         = "${local.vm_name}"
  location            = "${var.location}"
  resource_group_name = "${module.resource_group.resource_group_name}"
  subnet_id           = "${module.subnet.id}"
  vm_size             = "${var.vm_size}"
  tags                = "${merge(var.default_tags,tomap({type="application-server"}))}"
  managed_disk_id     = "${module.disk.id}"
  network_security_group_id = "${module.nsg.id}"
  depends_on = [
    module.resource_group,module.subnet,module.disk,module.nsg, 
  ]
}

module "key_vault" {
  providers = {
    azurerm.dns =  azurerm.dns
   }
  source                = "../../modules/key-vault"
  azure_key_vault_name  = "${local.azure_key_vault_name}"
  location              = "${var.location}"
  resource_group_name   = "${module.resource_group.resource_group_name}"
  subnet_id             = "${data.azurerm_subnet.pe-subnet.id}"
  tags                  = "${merge(var.default_tags,tomap({type="Key_vault"}))}"
  depends_on = [
    module.resource_group,
  ]

}

/*
module "cognitive_service" {
  source = "../../modules/cognitive-service"
  cognitive_service_name = "${local.cognitive_service_name}"
  location = "${var.location}"
  resource_group_name = "${module.resource_group.resource_group_name}"
  cognitive_service_kind = "${var.cognitive_service_kind}"
  sku_name = "${var.cognitive_service_sku_name}"
  key_vault_id = "${module.key_vault.id}"
  subnet_id = "${data.azurerm_subnet.pe-subnet.id}"
  tags = "${merge(var.default_tags,tomap({type="data-cognitive_service"}))}"
  depends_on = [
    module.resource_group,
  ]
  
}

module "data_factory" {
  providers = {
    azurerm.dns =  azurerm.dns
   }
  source              = "../../modules/data-factory"
  data_factory_name   = "${local.data_factory_name}"
  location            = "${var.location}"
  resource_group_name = "${module.resource_group.resource_group_name}"
  runtime_compute_type = "${var.runtime_compute_type}"
  runtime_core         = "${var.runtime_core}"
  subnet_id             = "${data.azurerm_subnet.pe-subnet.id}"
  tags                = "${merge(var.default_tags,tomap({type="data-factory"}))}"
  depends_on = [
    module.resource_group,
  ]
}

module "storage_account" {
  source = "../../modules/storage_account"
  for_each = "${var.storage}"
  storage_account_name = "${local.storage_account_name}${each.value.name}"
  container_required = true
  storage_container_name = "${each.value.container}"
  resource_group_name = "${module.resource_group.resource_group_name}"
  location = "${var.location}"
  account_tier = "Standard"
  access_tier = "HOT"
  replication_type = "LRS"
  container_access_type = "private"
  subnet_id  = "${data.azurerm_subnet.pe-subnet.id}"
  key_vault_id = "${module.key_vault.id}"
  tags = "${merge(var.default_tags,tomap({type="data-storage_account"}))}"
  depends_on = [
    module.resource_group, 
  ]
}
*/
/*
module "databricks" {
  source = "../../modules/databricks"
  databrick_name = "${local.databrick_name}"
  vnet_resource_group_name = "${var.vnet_resource_group_name}"
  resource_group_name = "${module.resource_group.resource_group_name}"
  location = "${var.location}"
  databrick_sku = "${var.databrick_sku}"
  vnet_name = "${var.vnet_name}"
  virtual_network_id = "${data.azurerm_virtual_network.vnet.id}"
  public_sn_address_prefix = "${var.public_sn_address_prefix}"
  private_sn_address_prefix = "${var.private_sn_address_prefix}"
  tags = "${merge(var.default_tags,tomap({type="data-databricks"}))}"
   depends_on = [
    module.resource_group,
  ]
}


# module "databricks_cluster" {
#   source = "../modules/databrick-cluster"
#   databrick_cluster_name = "${var.databrick_name}-cluster"
#   spark_version           = "6.6.x-scala2.11"
#   node_type_id            = "standard_DS3_v2"
#   tags = "${merge(var.default_tags,tomap({type="databricks-cluster"}))}"
  
# }
*/
module "sql-server" {
  source = "../../modules/sql-server"
  for_each = "${var.sql_db}"
  sql_server_name = "${local.sql_server_name}-${each.value.server_name_suffix}"
  resource_group_name = "${module.resource_group.resource_group_name}"
  database_name = "${each.value.db}"
  location = "${var.location}"
  sql_server_version = "${var.sql_server_version}"
  subnet_id  = "${data.azurerm_subnet.pe-subnet.id}"
  key_vault_id = "${module.key_vault.id}"
  tags = "${merge(var.default_tags,tomap({type="sql-server"}))}"
  depends_on = [
     module.resource_group,
  ]
}


/*

module "storage_account_func_app" {
  source = "../../modules/storage_account"
  storage_account_name = "${local.storage_account_name}funapp"
  container_required = false
  storage_container_name = []
  resource_group_name = "${module.resource_group.resource_group_name}"
  location = "${var.location}"
  account_tier = "Standard"
  access_tier = "HOT"
  replication_type = "LRS"
  container_access_type = "private"
  subnet_id  = "${data.azurerm_subnet.pe-subnet.id}"
  key_vault_id = "${module.key_vault.id}"
  tags = "${merge(var.default_tags,tomap({type="function app storage account"}))}"
  depends_on = [
    module.resource_group, 
  ]
}

module "function_app" {
  source                    = "../../modules/function-app"
  count                     = "${length(var.function_app_suffix)}"
  function_app_name         = "${local.function_app_name}-${var.function_app_suffix[count.index]}"
  location                  = "${var.location}"
  resource_group_name       = "${module.resource_group.resource_group_name}"
  function_kind             = "${var.function_kind}"
  storage_account_name      = "${module.storage_account_func_app.name}"
  storage_account_primary_access_key = "${module.storage_account_func_app.primary_access_key}"
  depends_on = [
     module.resource_group, module.storage_account_func_app,
  ]
}
*/

module "azure_logic_app" {
  source = "../../modules/logic-app"
  count = "${length(var.logic_app_suffix)}"
  logic_app_name = "${local.logic_app_name}-${var.logic_app_suffix[count.index]}"
  resource_group_name = "${module.resource_group.resource_group_name}"
  location = "${var.location}"
  tags = "${merge(var.default_tags,tomap({type="data-logic-apps"}))}"
  depends_on = [
    module.resource_group,
  ]
}

module "eventhub" {
  source = "../../modules/event-hub"
  eventhub_namespace_name = "${local.eventhub_namespace_name}"  
  location = "${var.location}"
  resource_group_name = "${module.resource_group.resource_group_name}"
  Eventhub_sku = "${var.Eventhub_sku}"
  eventhub_capacity = "${var.eventhub_capacity}"
  tags = "${merge(var.default_tags,tomap({type="eventhub"}))}"
  key_vault_id = "${module.key_vault.id}"
  event_name = "${var.event_name}"
  subnet_id  = "${data.azurerm_subnet.pe-subnet.id}"
  depends_on = [
    module.resource_group,
  ]
}

module "user_identity" {
  source = "../../modules/managed-identities"
  resource_group_name = "${module.resource_group.resource_group_name}"
  location = "${var.location}"
}

module "storage_account_arm" {
 source                               = "../../modules/arm-template"
 storage_account_StorageAccountName   = "tamopssaarm"
 storage_account_storageAccountType   = "Standard_LRS"
 storage_account_location             = "${var.location}"
 storage_account_StorageAccountKind   = "StorageV2"
 storage_account_resource_group_name  = "${module.resource_group.resource_group_name}"
 storage_account_deployment_name      = "tamopsa-arm-deployment"
}