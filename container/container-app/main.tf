resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "az-backend-storage-${var.environment}-rg"
}