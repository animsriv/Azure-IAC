/* terraform {
  
  backend "azurerm" { 
    resource_group_name   = "dev-net"    
    storage_account_name  = "devstatesa"     
    container_name        = "devstatecon"     
    key                   = "terraform.tfstate"
    access_key            = "nUXxv9fT/hQPbSKGEbbbve50RjiCwls/nEy67GqdjE+tgdXNO+R3Hh1/8j+FNLpBtQWP8Zt1J7u0U49gz/S0FQ=="
   }
  

} */

terraform {
  backend "local" {
    
  }
}