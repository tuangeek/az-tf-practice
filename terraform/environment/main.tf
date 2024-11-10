# create the backend resource group and storage account

locals {
    environment = "development"
    location    = "eastus"
}

module "az-backend" {
    source = "../az-backend"

    # variables
    location = local.location
    environment = local.environment
}