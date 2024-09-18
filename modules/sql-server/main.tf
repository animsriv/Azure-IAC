data "azurerm_client_config" "current" {}

resource "azurerm_storage_account" "storage" {
  name                         = "${replace(var.sql_server_name, "-", "")}sa"
  resource_group_name          = "${var.resource_group_name}"
  location                     = "${var.location}"
  account_tier                 = "standard"
  account_replication_type     = "LRS" 
  
}

resource "random_password" "sqlpassword" {
  length = 20
  min_upper = 1
  min_lower = 1
  min_numeric = 1
  min_special = 1
  special = true
  override_special = "_%@#"
}
#Create Key Vault Secret
resource "azurerm_key_vault_secret" "username" {
  name         = "${var.sql_server_name}-username"
  value        = "adminsql"
  key_vault_id = "${var.key_vault_id}"
}
resource "azurerm_key_vault_secret" "password" {
  name         = "${var.sql_server_name}-password"
  value        = "${random_password.sqlpassword.result}"
  key_vault_id = "${var.key_vault_id}"
}

resource "azurerm_sql_server" "sql-server" {
  name                         = "${var.sql_server_name}"
  resource_group_name          = "${var.resource_group_name}"
  location                     = "${var.location}"
  version                      = "${var.sql_server_version}"
  administrator_login          = "${azurerm_key_vault_secret.username.value}"
  administrator_login_password = "${azurerm_key_vault_secret.password.value}"
  extended_auditing_policy {
    storage_endpoint                        = "${azurerm_storage_account.storage.primary_blob_endpoint}"
    storage_account_access_key              = "${azurerm_storage_account.storage.primary_access_key}"
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 360
  }
  tags                         = "${var.tags}"
}


resource "azurerm_private_endpoint" "default" {
  name                = "${var.sql_server_name}-pe"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = "${var.subnet_id}"

  private_service_connection {
    name                           = "${var.sql_server_name}-pvc"
    private_connection_resource_id = azurerm_sql_server.sql-server.id
    subresource_names              = [ "sqlServer" ]
    is_manual_connection           = false
  }
}

resource "azurerm_sql_database" "database" {
  count               = "${length(var.database_name)}"
  name                = "${var.database_name[count.index]}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  server_name         = "${azurerm_sql_server.sql-server.name}"

  extended_auditing_policy {
    storage_endpoint                        = "${azurerm_storage_account.storage.primary_blob_endpoint}"
    storage_account_access_key              = "${azurerm_storage_account.storage.primary_access_key}"
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 365
  }
  tags = "${var.tags}"
}

resource "azurerm_sql_active_directory_administrator" "default" {
  server_name         = azurerm_sql_server.sql-server.name
  resource_group_name = "${var.resource_group_name}"
  login               = "sqladmin"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = "6de5c731-3b8e-4db1-a504-41e5418cdc4d"
}


# resource "azurerm_role_assignment" "default" {
#   role_definition_name = "SQL data reader"
#   scope                = azurerm_sql_server.sql-server.id
#   principal_id         = "${var.adf_id}"
# }