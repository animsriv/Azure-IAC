resource "azurerm_template_deployment" "storage_account_arm" {
  name                = var.storage_account_deployment_name
  resource_group_name = var.storage_account_resource_group_name
  deployment_mode     = "Incremental"
  template_body       = file("../../modules/arm-template/templates/st.json",)
  parameters = {
    StorageAccountName      = var.storage_account_StorageAccountName
    storageAccountType      = var.storage_account_storageAccountType
    location                = var.storage_account_location
    StorageAccountKind      = var.storage_account_StorageAccountKind
  }
}