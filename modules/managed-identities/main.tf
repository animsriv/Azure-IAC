resource "azurerm_user_assigned_identity" "example" {
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  name = "search-api"
}

