resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "rg-streamlit-app-${var.environment}"
}

resource "azurerm_log_analytics_workspace" "aw" {
  name                = "aw-${var.prefix}-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "app_env" {
  name                       = "app-env-${var.prefix}-${var.environment}"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.aw.id
}

# get registry info
data "azurerm_container_registry" "acr" {
  name                     = var.registry_name
  resource_group_name      = var.registry_rg
}

data "azurerm_user_assigned_identity" "containerapp" {
  name                     = var.registry_pull_identity
  resource_group_name      = var.registry_rg
}

resource "azurerm_container_app" "ca" {
  name                         = "ca-${var.prefix}-${var.environment}"
  container_app_environment_id = azurerm_container_app_environment.app_env.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"
  
  identity {
    type         = "UserAssigned"
    identity_ids = [
      data.azurerm_user_assigned_identity.containerapp.id
    ]
  }
 
  registry {
    server   = data.azurerm_container_registry.acr.login_server
    identity = data.azurerm_user_assigned_identity.containerapp.id
  }

  template {
    min_replicas = 0
    container {
      name   = "streamlit-app"
      # image  = "${data.azurerm_container_registry.acr.login_server}/streamlit"
      image  = "appregistrydevelopmentacr.azurecr.io/streamlit:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    external_enabled           = true
    allow_insecure_connections = false
    target_port                = 8501
    transport                  = "auto"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}