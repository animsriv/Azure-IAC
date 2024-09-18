
variable "location" {
    type = string
    description = "Location"
}

variable "default_tags" {
    type = map(string)
    description = "list of tags"
}


variable "vnet_name" {
  description = "Name of the vnet to create"
  type = string
}



variable "private_endpoint_subnet" {
  description = ""
  type = string
}

variable "cognitive_service_sku_name" {
    description = ""
    default = ""
    type=string

}




variable "cognitive_service_kind" {
    description = ""
    default = ""
    type=string
}





variable "sql_server_version" {
    description = ""
    type = string
}



variable "subnet_id" {
  description = ""
  default = ""
  type = string
}
  


variable "storage_container_name" {
    description = ""
    default = []
    type = list(string)
}


variable "databrick_sku" {
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


variable "function_kind" {
  description = ""
  type= string
}

variable "vnet_resource_group_name" {
  description = ""
  type= string
}

variable "runtime_compute_type" {
    description = "compute type of runtime"
    type = string
}

variable "runtime_core" {
  description = "number of cores for runtime"
  type = number
}

variable "Eventhub_sku" {
    description = "sku of Event hub"
    type = string
  
}

variable "eventhub_capacity" {
  description = "capacity of Event hub"
  type = number
}
variable "event_name" {
    description = "Event Name"
    type = list(string)
  
}

variable "function_app_suffix" {
  description = "suffix of function app"
  type = list(string)
}
variable "client_id" {
  
}

variable "tenant_id" {
  
}

variable "subscription_id" {
  
}

variable "client_secret" {
  
}

variable "PROD_NONPROD" {
  
}

variable "SHORT_LOCATION" {
  
}

variable "TARGET_ENVIRONMENT" {
  
}

variable "Environment" {
  
}


variable "storage" {
  description = "storage account details"
  type = map(object({
    name = string
    container = list(string)
  })) 
}

variable "logic_app_suffix" {
  description = "list of logic app suffix"
  type = list(string)
}

variable "sql_db" {
  description = "list of sql databases"

  type = map(object({
    server_name_suffix = string
    db = list(string)
  }))
  
}


variable "disk_size" {
  description = "size of CDA disk"
  type = string
  
}

variable "subnet_prefix" {
  description = "size of disk" 
  type = string

}

variable "vm_size" {
  description = "size of vm"
  type = string
}

variable "vm_subnet_prefix" {
  description = "prefix of vm subnet"
  type = string
}