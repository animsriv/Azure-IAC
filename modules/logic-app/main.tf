 resource "azurerm_logic_app_workflow" "logic-app" {
  name                = "${var.logic_app_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"  
  tags                = "${var.tags}"              
} 

