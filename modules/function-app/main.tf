

resource "azurerm_storage_container" "default" {
  name = "${var.function_app_name}-container"
  storage_account_name = "${var.storage_account_name}"
  container_access_type = "private"
  
}


resource "azurerm_application_insights" "default" {
  name            = "${var.function_app_name}-appinsight"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  application_type = "web"
}

resource "azurerm_app_service_plan" "default" {
  name                = "${var.function_app_name}-service-plan"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  kind                = "${var.function_kind}"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "default" {
  name                       = "${var.function_app_name}"
  location                   = "${var.location}"
  resource_group_name        = "${var.resource_group_name}"
  app_service_plan_id        = "${azurerm_app_service_plan.default.id}"
  storage_account_name       = "${var.storage_account_name}"
  storage_account_access_key = "${var.storage_account_primary_access_key}"
  https_only                 = "true"
  version                    = "~3" 
  os_type                    = "linux"
}