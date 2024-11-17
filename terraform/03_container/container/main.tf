resource "azurerm_resource_group" "rg" {
  name     = "rg-container-registry-${var.environment}"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                     = "appregistry${var.environment}acr"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Standard"
  admin_enabled            = false
}

resource "azurerm_user_assigned_identity" "containerapp" {
  name                = "registry-identity-user-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# resource "azurerm_role_assignment" "containerapp" {
#   scope                = azurerm_container_registry.acr.id
#   role_definition_name = "acrpull"
#   principal_id         = azurerm_user_assigned_identity.containerapp.principal_id
# }