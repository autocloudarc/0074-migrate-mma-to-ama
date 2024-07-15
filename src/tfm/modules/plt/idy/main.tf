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
  name = var.rgp_iac
}

data "azurerm_resource_group" "idy" {
  name = var.rgp_idy
}

data "azurerm_user_assigned_identity" "umid" {
  provider = azurerm.iac
  name                = var.umi_name
  resource_group_name = var.rgp_iac
}

data "azurerm_monitor_data_collection_rule" "dcr" {
  provider = azurerm.management
  name                = var.dcr_prefix.dcr
  resource_group_name = var.mgt_law.rgp
}

resource "azurerm_management_group_policy_assignment" "ama_initiative_assignment_dcr" {
  name                 = var.ama_initiative_assignment.name_dcr
  policy_definition_id = var.ama_initiative_assignment.policy_set_def_id
  management_group_id  = data.azurerm_management_group.tgt.id
  location = var.primary_location
  identity {
    type = "UserAssigned"
    identity_ids = [var.umi_pol_id]
  }
  parameters = <<PARAMS
    {
      "enableProcessesAndDependencies": {
        "value": ${var.ama_init_bool.enableProcessesAndDependencies}
      },
      "bringYourOwnUserAssignedManagedIdentity": {
        "value": ${var.ama_init_bool.bringYourOwnUserAssignedManagedIdentity}
      },
      "userAssignedManagedIdentityName": {
        "value": "${data.azurerm_user_assigned_identity.umid.name}"
      },
      "userAssignedManagedIdentityResourceGroup": {
        "value": "${data.azurerm_user_assigned_identity.umid.resource_group_name}"
      },
      "scopeToSupportedImages": {
        "value": ${var.ama_init_bool.scopeToSupportedImages}
      },
      "dcrResourceId": {
        "value": "${data.azurerm_monitor_data_collection_rule.dcr.id}"
      }
    }
PARAMS
}

resource "azurerm_management_group_policy_assignment" "amr_arc_dcr" {
  name                 = var.ama_initiative_assignment.name_hybrid_dcr
  policy_definition_id = var.ama_initiative_assignment.policy_set_hybrid_vm_def_id
  management_group_id  = data.azurerm_management_group.tgt.id
  location = var.primary_location
  identity {
    type = "UserAssigned"
    identity_ids = [var.umi_pol_id]
  }
  parameters = <<PARAMS
    {
      "dcrResourceId": {
        "value": "${data.azurerm_monitor_data_collection_rule.dcr.id}"
      }
    }
PARAMS
}
