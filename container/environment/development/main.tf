# create the backend resource group and storage account

module "container-app" {
  source      = "../../container-app"
  environment = "development"
  location    = "eastus"
}