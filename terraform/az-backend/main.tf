# create a new resource group for the project

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = random_pet.rg_name.id
}

resource "random_pet" "rg_name" {
  prefix = "az-backend-storage-${var.environment}"
  separator = "-"
}