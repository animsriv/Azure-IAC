output "key_vault_nic_ip" {
  value = module.key_vault.nic_ip
}

output "account_id" {
  value = data.azurerm_client_config.current.client_id
}
