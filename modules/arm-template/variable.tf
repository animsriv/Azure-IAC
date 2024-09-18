variable "storage_account_StorageAccountName" {
  description = "Storage Account Name"
}
 
variable "storage_account_storageAccountType" {
  description = "Storage Account Type"
  default     = "Standard_LRS"
}
 
variable "storage_account_location" {
  description = "Storage Account Location"
}
 
variable "storage_account_StorageAccountKind" {
  description = "Storage Account Kind"
  default = "StorageV2"
}
 
variable "storage_account_resource_group_name" {
  description = "Storage Account Resource Group"
}
 
variable "storage_account_deployment_name" {
  description = "Storage Account Deployment Name"
}
