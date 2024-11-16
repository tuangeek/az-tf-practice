# create a new resource group for the project

data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "az-backend-storage-${var.environment}-rg"
}

resource "azurerm_storage_account" "sa" {
  name                     = "tfbackend${var.environment}sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  public_network_access_enabled = true
  min_tls_version          = "TLS1_2"

  shared_access_key_enabled = true
  allow_nested_items_to_be_public = false

  network_rules {
    default_action             = "Deny"
    ip_rules                   = []
  }

  blob_properties {
    delete_retention_policy {
      days = 30
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}


resource "azurerm_storage_container" "tf-states" {
  name                  = "tf-states-container"
  storage_account_id  = azurerm_storage_account.sa.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "this" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.client_id
}

#resource "azurerm_management_lock" "backend-lock" {
#  name       = "tfbackend${var.environment}"
#  scope      = azurerm_storage_account.sa.id
#  lock_level = "CanNotDelete"
#  notes      = "TF Backend can't be deleted in this subscription!"
#}


# virtual network
/*
resource "azurerm_virtual_network" "vn" {
  name                = "tfbackend${var.environment}-vn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# subnet group
resource "azurerm_subnet" "subnet" {
  name                 = "tfbackend${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_private_endpoint" "endpoint" {
  name                 = "tfbackend${var.environment}-pe"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  subnet_id            = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "tf_backend_${var.environment}_psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.sa.id
    subresource_names              = ["blob"]
  }
}

*/
