
location            = "UK South"

PROD_NONPROD= "na"
SHORT_LOCATION="uks"
TARGET_ENVIRONMENT="dev"
Environment="ppd"

default_tags = {
  environment = "DEV"
  Workstream  = "Data & MI"
}
vnet_name = "dev"
vnet_resource_group_name = "dev-net"



private_endpoint_subnet = "dev-pe"
subnet_prefix   = "10.134.20.0/24"


# Logic app

logic_app_suffix = ["duckcreek", "ukris", "ais"]

# Cognitive Services
cognitive_service_kind = "ComputerVision"
cognitive_service_sku_name = "S1"


# databricks
databrick_sku = "premium"
public_sn_address_prefix = "10.134.1.0/24"
private_sn_address_prefix = "10.134.2.0/24"


# SQL database
sql_server_version = "12.0"
# sql_db = {
#   "pods" = {
#     db = [ "PODS" ]
#     server_name_suffix = "pods"
#   },
#   "cods" = {
#     db = [ "CODS" ]
#     server_name_suffix = "cods"
#   }
# }
sql_db = {
  "pods" = {
    db = [ "PODS" ]
    server_name_suffix = "pods"
  }
}

# Function App
function_kind = "FunctionApp"
function_app_suffix = ["psr", "lpd", "lbd", "lps", "ibd"]

# Event Hub
Eventhub_sku = "Standard"
eventhub_capacity = 1
event_name = ["sample1","sample2"]


# Storage
/*
storage = {
  "prc" = {
    container = [ "policy", "claims" ]
    name = "prc"
  },
  "raw" = {
    container = [ "policy", "claims" ]
    name = "raw"
  },
  "stg" = {
    container = [ "policy", "claims" ]
    name = "stg"
  }
}
*/
storage = {
  "prc" = {
    container = [ "policy", "claims" ]
    name = "prc"
  }
}

# datafactory

runtime_compute_type = "ComputeOptimized"
runtime_core = 8




disk_size = "50"
vm_size = "Standard_D4s_v3"

vm_subnet_prefix = "10.134.21.0/24"