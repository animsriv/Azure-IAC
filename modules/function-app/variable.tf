variable "location" {
    description = ""
    default = ""
    type = string
}

variable "resource_group_name" {
    description = ""
    default = ""
    type = string
}

variable "function_app_name" {
    description = ""
    default = ""
    type = string
}
variable "function_kind" {
    description = ""
    default = ""
    type = string
}

variable "storage_account_primary_access_key" {
  description = "storage account primary access key"
  type = string  
}

variable "storage_account_name" {
  description = "storage account name"
  type = string
}