# create the backend resource group and storage account

module "az-backend" {
    source = "../az-backend"

    # variables
    location = var.location
    environment = var.environment
}