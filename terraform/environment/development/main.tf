# create the backend resource group and storage account
module "az-backend" {
  source      = "../../az-backend"
  environment = "development"
  location    = "eastus"
}