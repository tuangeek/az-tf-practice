# create a new resource group for the project

resource "random_pet" "rg_name" {
  prefix = "az-backend-storage-${var.environment}-rg"
  separator = "-"
}

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

  blob_properties {
    delete_retention_policy {
      days = 30
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}



resource "azurerm_management_lock" "backend-lock" {
  name       = "tfbackend${var.environment}"
  scope      = azurerm_storage_account.sa.id
  lock_level = "CanNotDelete"
  notes      = "TF Backend can't be deleted in this subscription!"
}


/*

# virtual network
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

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action", 
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
      ]
    }
  }
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