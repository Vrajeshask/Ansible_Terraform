terraform {
  backend "azurerm" {
    storage_account_name = "terraformncpl"
    container_name       = "tffiles"
    key                  = "terraform.tfstate"
   
  }
}