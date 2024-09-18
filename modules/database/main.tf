resource "azurerm_sql_database" "database" {
  name                = "${var.database_name}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  server_name         = "${var.sql_server_name}"

  extended_auditing_policy {
    storage_endpoint                        = "${var.sql_storage_primary_blob_endpoint}"
    storage_account_access_key              = "${var.sql_storage_primary_access_key}"
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 365
  }
  tags = "${var.tags}"
}