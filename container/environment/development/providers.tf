terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "az-backend-storage-development-rg"
    storage_account_name = "tfbackenddevelopmentsa"
    container_name       = "tf-states-container"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  storage_use_azuread = true
  subscription_id     = "b18dd83b-0fb0-4bb3-8866-f908d0b223d6"
}
