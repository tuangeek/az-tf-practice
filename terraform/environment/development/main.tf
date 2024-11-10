# create the backend resource group and storage account

provider "azurerm" {
  features {}
  default_tags {
    tags = {
      Environment = "development"
      Name        = "Default Provider"
      Project     = "TF AZ Practice"
    }
  }
}

module "az-backend" {
  source      = "../../az-backend"
  environment = "development"
  location    = "eastus"
}