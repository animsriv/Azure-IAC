provider "azurerm" {
    client_id = var.client_id
    client_secret = var.client_secret
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    features {}
}


provider "azurerm" {
    features {}
    alias = "dns"
    client_id = var.client_id
    client_secret = var.client_secret
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    skip_provider_registration = true
}