variable "database_name" {
    description = ""
    type = string
}

variable "resource_group_name" {
    description = ""
    type = string
}

variable "location" {
    description = ""
    type = string
}

variable "sql_server_name" {
    description = ""
    type = string
}

variable "sql_storage_primary_blob_endpoint" {
    description = ""
    type = string
}

variable "sql_storage_primary_access_key" {
    description = ""
    type = string
}

variable "tags" {
    description = ""
    type = map(string)
  
}