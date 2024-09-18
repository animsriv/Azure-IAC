locals {
  resource_group_name="rg-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}dp"

  data_factory_name = "adf-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}"
  
  logic_app_name = "app-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}"
  
  function_app_name="func-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}"
  
  sql_server_name = "sql-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}"
  
  storage_account_name = "st${var.PROD_NONPROD}${var.SHORT_LOCATION}${var.TARGET_ENVIRONMENT}${var.Environment}"
  
  cognitive_service_name = "cogs-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}"
  
  databrick_name = "adb-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}"

  azure_key_vault_name = "akv-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}"

  eventhub_namespace_name = "evh-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}"

  subnet_name = "sbnt-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}-vm"

  vm_name = "vm-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}"

  nsg_name = "nsg-${var.PROD_NONPROD}-${var.SHORT_LOCATION}-${var.TARGET_ENVIRONMENT}-${var.Environment}"
}