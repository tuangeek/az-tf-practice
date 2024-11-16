output "keyvault_name"{
    value = azurerm_key_vault.kv.name
}

output "keyvault_group_name" {
    value = azurerm_resource_group.rg.name
}