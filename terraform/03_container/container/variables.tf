variable "location" {
    type = string
    default     = "eastus"
    description = "Location of the resource group."
}

variable "environment" {
    type = string
    description = "The environment"
}

variable "keyvault_name" {
    type = string
    description = "The keyvalut name"
}

variable "keyvault_resource_group" {
    type = string
    description = "The keyvalut resource group"
}