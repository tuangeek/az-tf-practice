module "arc" {
  source      = "../../container"
  environment = "development"
  location    = "eastus"
  keyvault_name = "practicedevelopmentkv"
  keyvault_resource_group = "kv-rg-development"
}