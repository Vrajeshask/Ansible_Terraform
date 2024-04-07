terraform {
  backend "azurerm" {
    storage_account_name = "terraformncpl"
    container_name       = "tffiles"
    key                  = "terraform.tfstate"
    access_key           = "1xy3AIAL6hzwPNHaLQiD+rU+mlVfFAaq25Nbqm95OH0iFJWM7woZMuq/5ydao1VVe9LWrsRFzLYn+ASt+hdxkA=="
  }
}