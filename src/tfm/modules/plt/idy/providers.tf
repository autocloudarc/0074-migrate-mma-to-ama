terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.115.0"
      configuration_aliases = [
        azurerm.connectivity,
        azurerm.management,
        azurerm.iac
      ]
    }
  }
}