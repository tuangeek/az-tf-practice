module "kv" {
  source      = "../../keyvault"
  environment = "development"
  location    = "eastus"
}