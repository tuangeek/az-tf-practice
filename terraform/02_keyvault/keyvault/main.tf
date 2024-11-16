data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "kv-rg-${var.environment}"
  location = "West Europe"
}

resource "azurerm_key_vault" "kv" {
  name                        = "practice${var.environment}kv"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

# allow service principal
resource "azurerm_key_vault_access_policy" "allow_sp" {
    key_vault_id = azurerm_key_vault.kv.id
    tenant_id    = data.azurerm_client_config.current.tenant_id
    object_id    = data.azurerm_client_config.current.object_id

    key_permissions = [
        "Get",
        "Update"
    ]

    secret_permissions = [
        "Get",
        "Set"
    ]

    storage_permissions = [
        "Get",
        "Update"
    ]
}

/*
# give service principal wirte access
resource "azurerm_role_assignment" "this" {
    scope                = data.azurerm_subscription.primary.id
    role_definition_name = "Key Vault Contributor"
    principal_id         = data.azurerm_client_config.current.client_id
}
*/