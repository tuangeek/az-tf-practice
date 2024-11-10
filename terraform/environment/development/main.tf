# create the backend resource group and storage account

provider "azurerm" {
  features {}
}

module "az-backend" {
  source      = "../../az-backend"
  environment = "development"
  location    = "eastus"
}