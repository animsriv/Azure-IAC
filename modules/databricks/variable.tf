variable "databrick_name" {
    description = ""
    default = ""
    type = string  
}

variable "resource_group_name" {
    description = ""
    default = ""
    type = string  
}

variable "location" {
    description = ""
    default = ""
    type = string  
}

variable "virtual_network_id" {
    description = ""
    default = ""
    type = string  
}

variable "databrick_sku" {
    description = ""
    default = ""
    type = string  
}
variable "vnet_name" {
    description = ""
    default = ""
    type = string  
}

variable "databrick_keyvault_sku" {
    description = ""
    default = ""
    type = string  
}
variable "public_sn_address_prefix" {
    description = ""
    default = ""
    type = string 
}

variable "private_sn_address_prefix" {
    description = ""
    default = ""
    type = string 
}

variable "private_sn_endpoint_address_prefix" {
    description = ""
    default = ""
    type = string 
}

variable "tags" {
    description = ""
    default = {}
    type = map(string)
  
}

variable "vnet_resource_group_name" {
  description = ""
  type= string
}