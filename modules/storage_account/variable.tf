variable "storage_account_name" {
    description = ""
    default = ""
    type = string
}

variable "storage_container_name" {
    description = ""
    default = []
    type = list(string)
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
variable "account_tier" {
    description = ""
    default = ""
    type = string
}

variable "replication_type" {
    description = ""
    default = ""
    type = string  
}
variable "container_access_type" {
    description = ""
    default = ""
    type =   string
}

variable "subnet_id" {
  description = ""
  type = string
}

variable "tags" {
    description = ""
    type = map(string)
  
}

variable "access_tier" {
    description = ""
    type = string
}

variable "key_vault_id" {
    description = "key vault id"
    type = string
}

variable "container_required" {
    description = "container_required"
    type = bool
  
}