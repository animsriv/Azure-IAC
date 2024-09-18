variable "eventhub_namespace_name" {
    description = "Event hub namespace name"
    type = string
}

variable "resource_group_name" {
    description = "Resource group name"
    type = string 
}

variable "location" {
    description = "Location"
    type = string
  
}

variable "Eventhub_sku" {
    description = "sku of Event hub"
    type = string
  
}

variable "eventhub_capacity" {
  description = "capacity of Event hub"
  type = number
}

variable "tags" {
 description = "tags"
 type= map(string) 
}

variable "event_name" {
    description = "Event Name"
    type = list(string)
  
}

variable "subnet_id" {
  description = "subnet id for private endpoint"
  type = string
}

variable "key_vault_id" {
  description = ""
  type = string
  
}