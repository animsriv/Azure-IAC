
variable "data_factory_name" {
  description = ""
  default = ""
}

variable "location"{
    description=""
    default=""
}

variable "resource_group_name"{
    description=""
    default=""
}


variable "tags"{
    description=""
    type=map(string)
}


variable "runtime_compute_type" {
    description = "compute type of runtime"
    type = string
}

variable "runtime_core" {
  description = "number of cores for runtime"
  type = number
}
variable "subnet_id" {
  description = ""
  type = string
  
}