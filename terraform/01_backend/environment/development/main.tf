# create the backend resource group and storage account
module "az-backend" {
  source      = "../../backend"
  environment = "development"
  location    = "eastus"
}