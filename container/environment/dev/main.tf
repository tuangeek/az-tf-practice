# create the backend resource group and storage account

locals {
  environment = "development"
}

module "container-app" {
  source        = "../../container-app"
  environment   = local.environment
  location      = "eastus"
  image         = "appregistrydevelopmentacr.azurecr.io/streamlit"
  registry_name = "appregistry${local.environment}acr"
  registry_rg   = "rg-container-registry-${local.environment}"
  registry_pull_identity = "registry-identity-user-${local.environment}"
}