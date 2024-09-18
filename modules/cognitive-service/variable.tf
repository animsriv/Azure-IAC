variable "cognitive_service_name" {
    description = "This is for cognitive service name"
    default = ""
    type=string  
}

variable "cognitive_service_kind" {
    description = "This is for cognitive service kind"
    default = "Computer Vision"
    type=string
}

variable "resource_group_name" {
  description = "This is for resource group name"
  default = ""
  type=string
}

variable "location" {
  description = "This is for location"
  default = ""
  type=string
}

variable "sku_name" {
    description = "This is for sku name"
    default = "S0"
    type=string

}
variable "tags" {
  description = "This is for tags"
  type= map(string)
}

variable "key_vault_id" {
  description = "This is for key vault id"
  type = string  
}

variable "subnet_id" {
  description = ""
  type = string
}