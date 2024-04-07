terraform {
  backend "azurerm" {
    storage_account_name = "terraformncpl"
    container_name       = "tffiles"
    key                  = "terraform.tfstate"
    access_key           = "haauFRwtP+cbwSXuWI47dl2eV3Lvov4gKyKh9E27atl7/GXbpA8ibiFBwKycFSeHWN46Mcf89JnM+AStjJEznQ=="
  }
}