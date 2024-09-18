output "logic_app_id" {
    description = "Logic app id"
    value = "${azurerm_logic_app_workflow.logic-app.id}"
}