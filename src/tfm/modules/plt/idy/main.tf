data "azurerm_virtual_network" "con" {
  provider            = azurerm.connectivity
  name                = var.hub_vnt.name
  resource_group_name = var.hub_vnt.rgp
}

data "azurerm_log_analytics_workspace" "mgt" {
  provider            = azurerm.management
  name                = var.mgt_law.name
  resource_group_name = var.mgt_law.rgp
}

data "azurerm_management_group" "tgt" {
  display_name = var.target_mg_name
}

data "azurerm_resource_group" "iac" {
  provider = azurerm.iac
  name = var.rgp_iac.name
}

data "azurerm_user_assigned_identity" "umid" {
  provider = azurerm.iac
  name                = var.umi_name
  resource_group_name = var.rgp_iac.name
}

data "azurerm_monitor_data_collection_rule" "dcr" {
  provider = azurerm.management
  name                = var.dcr_type.dcr
  resource_group_name = var.mgt_law.rgp
}

data "azurerm_monitor_data_collection_rule" "dcr-ext" {
  name                = var.dcr_type.dcr-ext
  resource_group_name = var.mgt_law.rgp
}

resource "random_uuid" "rnd" {
}

resource "azurerm_resource_group" "idy" {
  name     = var.rgpName
  location = var.primary_location
}

# resource "azurerm_monitor_data_collection_endpoint" "ama_dce" {
#   name                = var.ama_dce.name
#   resource_group_name = azurerm_resource_group.mgt.name
#   location            = var.primary_location

#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "azurerm_management_group_policy_assignment" "ama_initiative_dcr" {
  name                 = var.ama_initiative.name
  policy_definition_id = var.ama_initiative.policy_set_def_id
  management_group_id  = data.azurerm_management_group.tgt.id
  identity {
    type = "SystemAssigned"
  }
  parameters = <<PARAMS
    {
      "enableProcessesAndDependencies": {
        "value": "${var.ama_init_bool.enableProcessesAndDependencies}"
      },
      "bringYourOwnUserAssignedManagedIdentity": {
        "value": "${var.ama_init_bool.bringYourOwnUserAssignedManagedIdentity}"
      },
      "userAssignedManagedIdentityName": {
        "value": "${data.azurerm_user_assigned_identity.umid.name}"
      },
      "userAssignedManagedIdentityResourceGroup": {
        "value": "${data.azurerm_user_assigned_identity.umid.resource_group_name}"
      },
      "scopeToSupportedImages": {
        "value": "${var.ama_init_bool.scopeToSupportedImages}"
      },
      "dcrResourceId": {
        "value": "${var.ama_initiative.dcrResourceId}"
      }
    }
PARAMS
}

resource "azurerm_management_group_policy_assignment" "ama_initiative_dcr_ext" {
  name                 = var.ama_initiative.name
  policy_definition_id = var.ama_initiative.policy_set_def_id
  management_group_id  = data.azurerm_management_group.tgt.id
  identity {
    type = "SystemAssigned"
  }
  parameters = <<PARAMS
    {
      "enableProcessesAndDependencies": {
        "value": "${var.ama_init_bool.enableProcessesAndDependencies}"
      },
      "bringYourOwnUserAssignedManagedIdentity": {
        "value": "${var.ama_init_bool.bringYourOwnUserAssignedManagedIdentity}"
      },
      "userAssignedManagedIdentityName": {
        "value": "${data.azurerm_user_assigned_identity.umid.name}"
      },
      "userAssignedManagedIdentityResourceGroup": {
        "value": "${data.azurerm_user_assigned_identity.umid.resource_group_name}"
      },
      "scopeToSupportedImages": {
        "value": "${var.ama_init_bool.scopeToSupportedImages}"
      },
      "dcrResourceId": {
        "value": "${var.ama_initiative.dcrExtResourceId}"
      }
    }
PARAMS
}
