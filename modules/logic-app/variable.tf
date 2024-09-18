variable "logic_app_name" {
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

variable "tags" {
    description = ""
    default = {}
    type = map(string)
}