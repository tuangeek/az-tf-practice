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
    resource_group_name  = "az-backend-storage-development-rg"  # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "tfbackenddevelopmentsa"        # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tf-states-container"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "arc-development.terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
    use_azuread_auth     = true                            # Can also be set via `ARM_USE_AZUREAD` environment variable.
  }
}

provider "azurerm" {
  features {}
}