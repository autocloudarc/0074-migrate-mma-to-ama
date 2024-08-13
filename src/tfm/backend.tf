// backend state file
terraform {
  backend "azurerm" {
      resource_group_name = "rgp-iac-eu2-01"
      storage_account_name = "1sta710ada92"
      container_name = "tf-tfstate"
      key = "ama.tfstate"
      use_oidc = true
      subscription_id = "976c53b8-965c-4f97-ab51-993195a8623c"
      tenant_id = "54d665dd-30f1-45c5-a8d5-d6ffcdb518f9"
  }
}
