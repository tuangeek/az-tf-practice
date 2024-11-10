output "random_group_name" {
  value = random_pet.rg_name.id
}

output "azurerm_resource_group"{
  value = azurerm_resource_group.rg
}