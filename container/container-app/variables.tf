variable "location" {
    type = string
    default     = "eastus"
    description = "Location of the resource group."
}

variable "environment" {
    type = string
    description = "The environment"
}

variable "registry_name"{
    type = string
    description = "Registry name"
}

variable "registry_rg"{
    type = string
    description = "Registry resource group"
}

variable "registry_pull_identity" {
    type = string
    description = "Registry identity to pull image"
}

variable "prefix" {
    type = string
    default = "streamlit-app"
    description = "The environment"
}

variable "image" {
    type = string
    description = "The contianer image"
}
