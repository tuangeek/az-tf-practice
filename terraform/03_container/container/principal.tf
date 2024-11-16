# Give service principal access to azurerm_container_registry

data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "this" {
}

resource "azurerm_role_assignment" "example" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Container Registry Repository Writer"
  principal_id         = data.azurerm_client_config.this.object_id
}

/* 
# create application and principal

locals {
    current_time           = timestamp()
    end_date               = formatdate("YYYY-MM-DD", timeadd(local.current_time, "180d"))
}

# create an application and principal
resource "azurerm_azuread_application" "acr_app" {
  name = "acr_app"
}

resource "azurerm_resource_provider_registration" "acr_sp" {
  application_id = azurerm_azuread_application.acr_app.application_id
}

resource "azurerm_azuread_service_principal_password" "acr_sp_pass" {
  service_principal_id = azurerm_resource_provider_registration.acr_sp.id
  value                = random_password.acr_sp_pass.value
  end_date             = local.end_date
}

resource "random_password" "acr_sp_pass" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?" 
}

data "azurerm_key_vault" "vault" {
  name = var.keyvault_name
  resource_group_name = var.keyvault_resource_group
}

resource "azurerm_key_vault_key" "key" {
  name = "acr-${var.environment}-password"

  key_vault_id = data.azurerm_key_vault.vault.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
}
*/