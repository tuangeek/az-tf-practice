# create a new resource group for the project

resource "random_pet" "rg_name" {
  prefix = "az-backend-storage-${var.environment}-rg"
  separator = "-"
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = random_pet.rg_name.id
}

resource "azurerm_storage_account" "sa" {
  name                     = "azbackendstorage${var.environment}sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}