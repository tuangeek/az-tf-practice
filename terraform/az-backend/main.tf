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
  name                     = "tfbackend${var.environment}sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  public_network_access_enabled = false
  min_tls_version          = "TLS1_2"
  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }
  shared_access_key_enabled = false
  allow_nested_items_to_be_public = false
}

resource "azurerm_private_endpoint" "endpoint" {
  name                 = "tfbackend${var.environment}-pe"
  location             = azurerm_resource_group.sa.location
  resource_group_name  = azurerm_resource_group.sa.name
  subnet_id            = azurerm_subnet.sa.id

  private_service_connection {
    name                           = "tf_backend_${var.environment}_psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.sa.id
    subresource_names              = ["blob"]
  }
}