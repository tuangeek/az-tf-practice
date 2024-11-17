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
    key                  = "container-app.terraform.tfstate" # this should be change for each project
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}

  storage_use_azuread = true
  subscription_id     = "b18dd83b-0fb0-4bb3-8866-f908d0b223d6"
}
