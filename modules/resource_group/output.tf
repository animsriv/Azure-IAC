output "ResourceGroupId" {  
    description = "id of the resource group provisioned"  
    value = "${azurerm_resource_group.resource_group.id}"  
}  
output "resource_group_name" {  
    description = "name of the resource group provisioned"  
    value = "${azurerm_resource_group.resource_group.name}"  
}  