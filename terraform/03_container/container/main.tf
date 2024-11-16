resource "azurerm_resource_group" "rg" {
  name     = "app-container-${var.environment}-rg"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                     = "appregistry${var.environment}acr"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Standard"
  admin_enabled            = false
}