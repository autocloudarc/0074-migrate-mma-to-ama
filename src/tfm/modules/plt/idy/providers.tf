terraform {
  required_providers {
    azurerm = {
      skip_provider_registration = true
      source = "hashicorp/azurerm"
      version = "~>3.108.0"
      configuration_aliases = [
        azurerm.connectivity,
        azurerm.management,
        azurerm.iac
      ]
    }
  }
}