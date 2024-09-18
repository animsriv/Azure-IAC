variable "azure_key_vault_name" {
    description = ""
    default = ""
    type=string
}

variable "resource_group_name" {
    description = ""
    default = ""
    type=string
}


variable "location" {
    description = ""
    default = ""
    type=string
}

variable "subnet_id" {
  description = ""
  type = string
}

variable "tags" {
  description = ""
  type        = map(string)
  default     = {}
}